//
//  ChatPartnerPickerViewModel.swift
//  WhatsApp
//
//  Created by Apple on 17/11/2026.
//

import Foundation
import FirebaseAuth
import Firebase

enum ChannelCreationRoute{
    case addGroupMembers
    case setUpGroup
    
}

enum ChannelCreationError:Error{
    case noChatPartnerSelected
    case failedToGetUniqueIds
    
}

@Observable
final class ChatPartnerPickerViewModel{
    var channelName:String = ""
    var selectedChatPartners = [UserItem]()
    let maxGroupUser = 12
    
    var navStack = [ChannelCreationRoute]()
    var users = [UserItem]()
    var lastCursor:String?
    
    init() {
        Task{
            await fetchUsers()
        }
    }
    
    
    
    
    var showSelectedChatPartners:Bool{
        return  !selectedChatPartners.isEmpty
    }
    
    var paginatable:Bool{
        return !users.isEmpty
    }
    
    var createButtodDisabled:Bool{
        return  selectedChatPartners.isEmpty || channelName.isWhiteSpaceOrEmpty
    }
    var nextButtodDisabled:Bool{
        return selectedChatPartners.isEmpty
    }
    
    func fetchUsers()async{
        do  {
            let userNode = try await UserService.shared.fetchPaginatedUsers(cursor: lastCursor, pageSize: 5)
            lastCursor = userNode.cursor
            var fetchedUsers = userNode.users
            fetchedUsers = fetchedUsers.filter{$0.id != Auth.auth().currentUser?.uid}
            users.append(contentsOf: fetchedUsers)
        }catch{
            print("Error has occurred while fetching users \(error.localizedDescription)")
        }
    }
    
    
    
    func handleChatPartnerSelection(item:UserItem){
        if(isUserSelected(user: item)){
            guard let index = selectedChatPartners.firstIndex(where: {$0.id == item.id}) else{ return }
            selectedChatPartners.remove(at: index)
        }else{
            selectedChatPartners.append(item)
        }
    }
    
    
    
    func isUserSelected(user:UserItem)->Bool{
        return selectedChatPartners.contains { item in item.id == user.id}
    }
    
  
    
    
    func createDirectChannel(user:UserItem, completionHandler: @escaping(ChannelItem)->Void){
        selectedChatPartners.removeAll()
        handleChatPartnerSelection(item: user)
        
        Task{
            if let channelId = await verifyDirectChannelExist(chatPartner: user.id){
                
                if var channel = await fetchChanneLbyId(channelId: channelId){
                    channel.members = selectedChatPartners
                    completionHandler(channel)
                }
                
                
            }else{
                let channelCreation = handleChannelCreation(isDirectChannel: true,channelName: nil)
                switch channelCreation {
                case .success(let channel):
                    completionHandler(channel)
                case .failure(let failure):
                    print("Failed to create direct channel \(failure.localizedDescription)")
                }
                
            }
            
            
        }
    }
    
    
    func createGroupChannel(channelName:String?, completionHandler: @escaping(ChannelItem)->Void){
        let channelCreation = handleChannelCreation(channelName: channelName)
        switch channelCreation {
        case .success(let channel):
            completionHandler(channel)
        case .failure(let failure):
            print("Failed to create group channel \(failure.localizedDescription)")
        }
        
    }
    
    
    private func verifyDirectChannelExist(chatPartner:String)async ->String?{
        guard let currentUserId = Auth.auth().currentUser?.uid else{ return nil}
        
        return  await withCheckedContinuation { continuation in
            FirebaseConstants.directChannels.child(currentUserId).child(chatPartner).observeSingleEvent(of:.value) { snapshot in
                continuation.resume(returning:  snapshot.value as? String)
            } withCancel: {error in
                continuation.resume(returning: nil)
                
            }
        }
        
        
        
    }
    
    
    private func fetchChanneLbyId(channelId:String)async ->ChannelItem?{
        await withCheckedContinuation { continuation  in
            FirebaseConstants.ChannelRef.child(channelId).observeSingleEvent(of:.value) { snapshot in
                let channelDict = snapshot.value as? [String:Any ] ?? [:]
                let channel = ChannelItem(dict: channelDict)
                continuation.resume(returning: channel)
                
            } withCancel: { error in
                continuation.resume(returning: nil)
                
            }
        }
        
    }
    
    
    
    private func handleChannelCreation(isDirectChannel:Bool = false ,channelName:String?)->Result<ChannelItem,Error>{
        
        guard !selectedChatPartners.isEmpty else { return .failure(ChannelCreationError.noChatPartnerSelected)}
        
        guard let channelId = FirebaseConstants.ChannelRef.childByAutoId().key,
              let currentUserId = Auth.auth().currentUser?.uid,
              let messageId = FirebaseConstants.ChannelMessages.childByAutoId().key
                else{ return .failure(ChannelCreationError.failedToGetUniqueIds)}
        
        let messageBroadCast = AdminMessage.channelCreated.rawValue
        
        var memberUids = selectedChatPartners.compactMap{$0.id}
        memberUids.append(currentUserId)
        
        let timestamp = Date().timeIntervalSince1970
        
        var channelDict:[String:Any] = [
            .channelId: channelId,
            .channelOwner: currentUserId,
            .channelLastMessage:messageBroadCast,
            .channelCreationTimestamp:timestamp,
            .channelLastMessageTimestamp: timestamp,
            .channelMemberUids: memberUids,
            .channelMemberCount:memberUids.count,
            .channelAdminUid:[currentUserId],
            .channelIsDirectChannel:isDirectChannel,
            .channelThumbnail:""
            
        ]
        
        if let channelName = channelName, !channelName.isWhiteSpaceOrEmpty{
            channelDict[.channelName] = channelName
        }
        let messageDict:[String:Any] = ["owner":currentUserId,"type":messageBroadCast,"timestamp":timestamp]
        
        
        FirebaseConstants.ChannelRef.child(channelId).setValue(channelDict)
        memberUids.forEach { userId in
            FirebaseConstants.ChannelUsers.child(userId).child(channelId).setValue(true)
        }
        
        
        if(isDirectChannel){
            let chatPartner = selectedChatPartners[0].id
            FirebaseConstants.directChannels.child(currentUserId).child(chatPartner).setValue(channelId)
            FirebaseConstants.directChannels.child(chatPartner).child(currentUserId).setValue(channelId)
        }
        
        FirebaseConstants.ChannelMessages.child(channelId).child(messageId).setValue(messageDict)
        
        var channel = ChannelItem(dict: channelDict)
        channel.members = selectedChatPartners
        
        return .success(channel)
        
        
    }
    
    
}
