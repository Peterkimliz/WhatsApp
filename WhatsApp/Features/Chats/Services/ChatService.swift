//
//  ChatService.swift
//  WhatsApp
//
//  Created by Apple on 18/11/2026.
//

import Foundation
import Firebase


protocol ChannelProvider{
    static var shared:ChannelProvider{ get }
    
    func sendMessage(channel:ChannelItem,user:UserItem,textMessage:String, completionHandler:()->Void)
    
    func fetchMessages(channel:ChannelItem,completionHandler:@escaping([MessageItem])->Void)
    
}


final class ChatService : ChannelProvider{
   
    
    static let shared: ChannelProvider = ChatService()
    private init(){
        
    }
    
    
    
    func fetchMessages(channel: ChannelItem, completionHandler: @escaping ([MessageItem]) -> Void) {
        
        FirebaseConstants.ChannelMessages.child(channel.id).observe(.value) { snapshot in
            let dict:[String:Any] = snapshot.value as? [String:Any] ?? [:]
            var messages = [MessageItem]()
            dict.forEach { key,value in
                let messageDict = value as?[String:Any] ?? [:]
                let messageItem = MessageItem(id: key, dict: messageDict)
                messages.append(messageItem)
                if messages.count == snapshot.childrenCount{
                    completionHandler(messages)
                }
            }
            
        } withCancel: {error in
            print("Error fetching chats \(error.localizedDescription)")
        }

        
    }
    
    func sendMessage(channel: ChannelItem, user: UserItem, textMessage: String, completionHandler: () -> Void) {
        
        guard let messageId = FirebaseConstants.ChannelMessages.childByAutoId().key else{return}
        let timestamp = Date().timeIntervalSince1970
        
        let channelDict:[String:Any] = [
            .channelLastMessage:textMessage,
            .channelLastMessageTimestamp:timestamp
        ]
        
        let messageDict:[String:Any] = [
            .message:textMessage,
            .messageOwner:user.id,
            .messageTimestamp:timestamp,
            .messageType: MessageType.text.title
            
        ]
        
        FirebaseConstants.ChannelRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.ChannelMessages.child(channel.id).child(messageId).setValue(messageDict)
        completionHandler()

        
    }
    
    
    
    
}

