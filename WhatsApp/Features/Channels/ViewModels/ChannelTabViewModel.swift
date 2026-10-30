//
//  ChannelTabViewModel.swift
//  WhatsApp
//
//  Created by Apple on 27/10/2026.
//

import SwiftUI
import FirebaseAuth
import Firebase
@Observable
final class ChannelTabViewModel{
    var showChatPartnerPicker = false
    var channel:ChannelItem?
    var navigateToChatScreen:Bool = false
    
    
    private var channelDict:[String:ChannelItem] = [:]
    
   private(set) var channels = [ChannelItem]()
    
    init(){
        fetchUserChannels()
    }
    
    func onChannelCreation(channelItem:ChannelItem){
        showChatPartnerPicker = false
        channel = channelItem
        navigateToChatScreen = true
        
    }
    
    
    func fetchUserChannels(){
        guard let currentUserId = Auth.auth().currentUser?.uid else{ return}
        FirebaseConstants.ChannelUsers.child(currentUserId).observe(.value){[weak self] item in
            guard let channelIds = item.value as? [String:Bool] else{ return}
            channelIds.forEach { (key,value) in
                self?.fetchChannelWithId(id: key)
            }
            
        } withCancel: {error in
            print("The following error occurred \(error.localizedDescription)")
        }
    }
    
    func fetchChannelWithId(id:String){
        FirebaseConstants.ChannelRef.child(id).observe(.value){[weak self] snapshot in
           guard let channelDict = snapshot.value as? [String:Any] else{ return}
           var channel = ChannelItem(dictionary: channelDict)
            
            self?.fetchChannelUsers(users: channel.membersUids) {users in
                channel.members.append(contentsOf: users)
                self?.channelDict[channel.id] = channel
                self?.reloadData()
            }} withCancel: {error in
            print("The following error occurred \(error.localizedDescription)")
        }
    }
    
    private func fetchChannelUsers(users:[String],completionHandler:@escaping([UserItem])->Void){
        guard let currentUserId = Auth.auth().currentUser?.uid else{ return}
        let usersIdsToFetch:[String] = users.filter {$0 != currentUserId}
        var users = [UserItem]()
      
        usersIdsToFetch.forEach { userId in
            FirebaseConstants.userReference.child(userId).observeSingleEvent(of: .value) { snapshot in
                guard let userDict = snapshot.value as? [String:Any] else{ return}
                let user = UserItem(dictionary: userDict)
                users.append(user)
                if(users.count == usersIdsToFetch.count){
                    completionHandler(users)
                }
                        
            } withCancel: { error in
                print("error occurred is \(error.localizedDescription)")
            }

            
            
        }
        
        
        
    }
    func reloadData(){
        self.channels = Array(channelDict.values)
        self.channels.sort{$0.lastMessageTimeStamp > $1.lastMessageTimeStamp}
    }
    
    
    
    
}
