//
//  ChannelTabViewModel.swift
//  WhatsApp
//
//  Created by Apple on 18/11/2026.
//

import Foundation
import FirebaseAuth
import Firebase

@Observable
final class ChannelTabViewModel{
    var navigateToChatScreen:Bool = false
    var showChatPartnerPicker:Bool = false
    var newChannel:ChannelItem?
    var channels = [ChannelItem]()
    
    var channelsDict:[String:ChannelItem] = [:]
    
    init(){
        fetchUserChannels()
    }
    
    
    func onChannelCreation(channel:ChannelItem){
        showChatPartnerPicker = false
        newChannel = channel
        navigateToChatScreen = true
        
    }
    
    
    func fetchUserChannels(){
        guard let currentUserId = Auth.auth().currentUser?.uid else{return}
        
        FirebaseConstants.ChannelUsers.child(currentUserId).observe(.value) {[weak self] snapshot in
            guard let dict = snapshot.value as? [String :Bool] else{return}
            dict.forEach { (key: String, value: Bool) in
                let channelId = key
                self?.fetchChannel(channelId: channelId)
            }
            
        } withCancel: { error in
            print("Error occurred while fetching  channel ids \(error.localizedDescription)")
        }
    }
    
    
    func fetchChannel(channelId:String){
        FirebaseConstants.ChannelRef.child(channelId).observe(.value) {[weak self] snapshot in
            let channelDict = snapshot.value as? [String:Any] ?? [:]
            var channel = ChannelItem(dict: channelDict)
            self?.fetchChannelUsers(users: channel.memberUids) {users in
                channel.members = users
                self?.channelsDict[channelId] = channel
                self?.reload()
            }
//            payref
            
        } withCancel: { error in
            print("Error occurred while fetching  channels \(error.localizedDescription)")
        }
    }
    
    
    
    func fetchChannelUsers(users:[String],compltionHandler:@escaping([UserItem])->Void){
        guard let currentUserId = Auth.auth().currentUser?.uid else { return}
        let filteredUsers = users.filter {$0 != currentUserId}
        var users = [UserItem]()
        
        
        filteredUsers.forEach { userId in
            FirebaseConstants.userReference.child(userId).observeSingleEvent(of: .value) {snapshot in
                guard let userDict = snapshot.value as? [String:Any] else{ return}
               
                let user = UserItem(dictionary: userDict)
               
                users.append(user)
                if(filteredUsers.count == users.count){
                    compltionHandler(users)
                }
            }

        }
        
        
        
        
        
    }
    
    
    func reload(){
        channels = Array(channelsDict.values)
        channels.sort{$0.lastMessageTimestamp > $1.lastMessageTimestamp}
    }
    
}
