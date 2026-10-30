//
//  ChatPartnerPickerViewModel.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI
import FirebaseAuth
import Firebase

enum ChannelCreationRoute{
    case addGroupMembers
    case setUpGroup
}

enum ChannelCreationErrors:Error{
    case noChatPartner
    case failedToGenerateGetIds
    
}



@Observable
final class ChatPartnerPickerViewModel{
    var navStack = [ChannelCreationRoute]()
    let maxGroupUser = 20
    var channelName:String = ""
    
    var lastCursor:String?
    var selectedChatPartners = [UserItem]()
    var users = [UserItem]()
    
    var paginatable:Bool{
        return !users.isEmpty
    }
    
    
    
    init(){
        Task{
            await fetchUsers()
        }
    }
    
    var showSelectedChatPartners:Bool{
        return !selectedChatPartners.isEmpty
    }
    
    var nextButtodDisabled:Bool{
        return selectedChatPartners.isEmpty
    }
    
    var createButtodDisabled:Bool{
        return selectedChatPartners.isEmpty || channelName.isWhiteSpaceOrEmpty
    }
    
    
    func handleChatPartnerSelection(item:UserItem){
        if isUserSelected(user: item){
            guard let index = selectedChatPartners.firstIndex(where: {$0.id == item.id }) else{ return}
            selectedChatPartners.remove(at:index)
        }else{
            selectedChatPartners.append(item)
        }
        
        
    }
    
    
    func isUserSelected(user:UserItem)->Bool{
        return selectedChatPartners.contains {$0.id == user.id}
    }
    
    func fetchUsers()async{
        do{
            let userNode = try await UserService.shared.fetchPaginatedUsers(cursor: lastCursor, pageSize: 5)
            let filteredUsers = userNode.users.filter {$0.id != Auth.auth().currentUser?.uid}
            self.users.append(contentsOf: filteredUsers)
            self.lastCursor = userNode.cursor
            
            print("Current cursor \(String(describing: lastCursor))")
            
        }catch{
            print("error occurrred is \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    
    private func channelCreation(channelName:String?,isDirectChannel:Bool = false)->Result<ChannelItem,Error>{
        guard !selectedChatPartners.isEmpty else{ return Result.failure(ChannelCreationErrors.noChatPartner)}
        
        guard let channelUid = FirebaseConstants.ChannelRef.childByAutoId().key,
              let currentUserUid = Auth.auth().currentUser?.uid,
              let messageUid = FirebaseConstants.ChannelMessages.childByAutoId().key else{ return Result.failure(ChannelCreationErrors.failedToGenerateGetIds) }
        
        let currentTimeStamp = Date().timeIntervalSince1970
        var memberUids = selectedChatPartners.compactMap{$0.id}
        memberUids.append(currentUserUid)
        let messageBroadcast:String = AdminMessage.channelCreated.rawValue
        
        let messageDict:[String:Any] = [
            "type":messageBroadcast,
            "owner":currentUserUid,
            "creationTimeStamp":currentTimeStamp
        ]
        
        
        var channelDict:[String:Any] = [
            .channelId:channelUid,
            .channelLastMessage:messageBroadcast,
            .channelLastMessageTimeStamp:currentTimeStamp,
            .channelCreationTimeStamp:currentTimeStamp,
            .channelOwner:currentUserUid,
            .channelMembersUids:memberUids,
            .channelAdminsUids:[currentUserUid],
            .channelMembersCount: memberUids.count,
            .channelIsDirectMessage: isDirectChannel
        ]
        
        if let channelName = channelName, !channelName.isWhiteSpaceOrEmpty {
            channelDict[.channelName] = channelName
        }
        
        FirebaseConstants.ChannelRef.child(channelUid).setValue(channelDict)
        memberUids.forEach { userId in
            FirebaseConstants.ChannelUsers.child(userId).child(channelUid).setValue(true)
        }
        
        if(isDirectChannel){
            let messagePartner = selectedChatPartners[0].id
            FirebaseConstants.directChannels.child(currentUserUid).child(messagePartner).setValue(channelUid)
            FirebaseConstants.directChannels.child(messagePartner).child(currentUserUid).setValue(channelUid)
        }
        FirebaseConstants.ChannelMessages.child(channelUid).child(messageUid).setValue(messageDict)
        
        
        var channel = ChannelItem(dictionary: channelDict)
        channel.members.append(contentsOf: selectedChatPartners)
        
        return Result.success(channel)
        
        
    }
    
    
    func createGroupChannel(channelName:String, completionHandler:@escaping(ChannelItem)->Void){
        let createdChannel = channelCreation(channelName: channelName)
        
        switch createdChannel {
        case .success(let newChannel):
          completionHandler(newChannel)
        case .failure(let failure):
            print("Failed to create group channel \(failure.localizedDescription)")
        }
        
    }
    

    func createDirectChannel(user:UserItem, completionHandler:@escaping(ChannelItem)->Void){
        selectedChatPartners.append(user)

        Task{
            if let channelId = await existingDirectChannelId(partnerId: user.id){
                if var channel = await fetchChannelById(channelId: channelId){
                    channel.members = selectedChatPartners
                    completionHandler(channel)
                }
                
                
            }else{
                let createdChannel = channelCreation(channelName: nil,isDirectChannel: true)
                        
                switch createdChannel {
                case .success(let newChannel):
                    completionHandler(newChannel)
                case .failure(let failure):
                    print("Failed to create direct channel \(failure.localizedDescription)")
                }
            }
        }
    }
    

    
    private func existingDirectChannelId(partnerId: String) async -> String? {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return nil }
        let ref = FirebaseConstants.directChannels.child(currentUserId).child(partnerId)

        return await withCheckedContinuation { continuation in
            ref.observeSingleEvent(of: .value) { snapshot in
                continuation.resume(returning: snapshot.value as? String)
            } withCancel: { error in
                print("Direct channel check failed: \(error.localizedDescription)")
                continuation.resume(returning: nil)
            }
        }
    }
    
    
    private func fetchChannelById(channelId: String) async -> ChannelItem? {
        await withCheckedContinuation { continuation in
            FirebaseConstants.ChannelRef.child(channelId).observeSingleEvent(of: .value) { snapshot in
                guard let dict = snapshot.value as? [String: Any] else {
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: ChannelItem(dictionary: dict))
            } withCancel: { _ in
                continuation.resume(returning: nil)
            }
        }
    }
    
 
 
   
    
    
    
    
}
