//
//  MessageItem.swift
//  WhatsApp
//
//  Created by Apple on 17/10/2026.
//

import SwiftUI

struct MessageItem:Identifiable{
    let id:String = UUID().uuidString
    let message:String
    let direction: MessageDirection
    let type:MessageType
    
    
    
}

extension MessageItem{
    
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
        MessageItem(message: "Hello There ", direction: .sent,type: .text),
        MessageItem(message: "Hello to sam,  how are you fairing this afternoon ", direction: .received,type: .text),
        MessageItem(message: "Yes iam doing very well concerning swift concurrency so far ", direction: .sent, type: .text),
        MessageItem(message: "Ahh Greate to hear this keep pushing", direction: .received,type: .text),
        MessageItem(message: "Check on this photo", direction: .received,type:.photo),
        MessageItem(message: "Check on this photo", direction: .sent,type:.photo),
        MessageItem(message: "", direction: .sent,type:.audio),
        MessageItem(message: "", direction: .received,type:.audio)
      
    ]
    
}
enum MessageType{
    case text, video, photo,audio
}

enum MessageDirection{
    case sent, received
}
