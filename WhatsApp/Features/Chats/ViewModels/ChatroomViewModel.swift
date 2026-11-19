//
//  ChannelRoomViewModel.swift
//  WhatsApp
//
//  Created by Apple on 18/11/2026.
//

import Foundation
import Combine

@Observable
final class ChatroomViewModel{
    private let channel:ChannelItem
    var textMessage:String = ""
    var currentUser:UserItem?
    var subscriptions = Set<AnyCancellable>()
    private(set) var messages = [MessageItem]()
    
    private var messagesDict:[String:MessageItem] = [ : ]
    
    
    init(channel: ChannelItem) {
        self.channel = channel
        listenToAuthState()
    }
    
    deinit {
        subscriptions.forEach { sub in sub.cancel()}
        subscriptions.removeAll()
        currentUser = nil
    }
    
    func listenToAuthState(){
        AuthService.shared.authState.receive(on: DispatchQueue.main).sink {[weak self]authState in
            switch authState{
            case .loggedIn(let user):
                self?.currentUser = user
                self?.fetchMessages()
            default:
                break
            }
            
        }.store(in: &subscriptions)
        
        
    }
    
    
    func sendMessage(){
        guard let currentUser = currentUser else {return}
        ChatService.shared.sendMessage(channel: channel, user: currentUser, textMessage: textMessage) {
            textMessage = ""
        }
        
    }
    
    func fetchMessages(){
        
        ChatService.shared.fetchMessages(channel: channel) { [weak self] messages in
            print("Messages are \(messages)")
            
            messages.forEach {message in
                self?.messagesDict[message.id] = message
                self?.reload()
            }
            
        }
        
    }
    
    
    
    func reload(){
        messages = Array(messagesDict.values)
        messages.sort {$0.timeStamp < $1.timeStamp}
    }
    
    
    
    
}
