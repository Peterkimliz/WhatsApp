//
//  MessageItem.swift
//  WhatsApp
//
//  Created by Apple on 17/10/2026.
//

import SwiftUI
import FirebaseAuth

struct MessageItem:Identifiable{
    var id:String
    var message:String
    var type:MessageType
    var owner:String
    var direction: MessageDirection{
        let currentUser = Auth.auth().currentUser
        return owner == currentUser?.uid ? .sent : .received
    }
    var timeStamp:Date
    
    
}

extension String{
    static let message = "text"
    static let messageOwner = "owner"
    static let messageTimestamp = "timestamp"
    static let messageType = "type"
}

extension MessageItem{
    
    init(id:String, dict:[String:Any]){
        self.id = id
        self.message = dict[.message] as? String ?? ""
        self.owner =  dict[.messageOwner] as? String ?? ""
        self.type = MessageType(stringText: dict[.messageType] as? String ?? "")
        let time = dict[.messageTimestamp] as? Double ?? 0
        self.timeStamp  = Date(timeIntervalSince1970: time)
    }
    
    
    
    var background:Color{
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    
    var alignment:Alignment{
        return direction == .sent ? .leading : .trailing
    }
    
    var  horizontalAlignment:Alignment{
        return direction == .sent ? .trailing : .leading
    }
    
    static let messagesStubs = [
        MessageItem(id: UUID().uuidString,message: "Hello There ",type: .text,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "Hello to sam,  how are you fairing this afternoon ",type: .text,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "Yes iam doing very well concerning swift concurrency so far ", type: .text,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "Ahh Greate to hear this keep pushing",type: .text,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "Check on this photo",type:.photo,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "Check on this photo",type:.photo,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "",type:.audio,owner: "1",timeStamp: Date()),
        MessageItem(id: UUID().uuidString, message: "",type:.audio,owner: "1",timeStamp: Date())
      
    ]
    
}
