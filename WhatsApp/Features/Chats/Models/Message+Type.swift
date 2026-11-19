//
//  Message+Type.swift
//  WhatsApp
//
//  Created by Apple on 29/10/2026.
//

import SwiftUI

enum AdminMessage:String{
    case channelCreated
    case memberAdded
    case memberRemoved
    case memberLeft
    case channelNameUpdated
}


enum MessageType{
    case text, video, photo,audio
    
    var title:String{
        switch self {
        case .text:
            return "text"
        case .video:
            return "video"
        case .photo:
            return "photo"
        case .audio:
            return "audio"
        }
    }
    
   
}

extension MessageType{
    
    init(stringText:String){
        switch stringText {
        case "text":
            self = MessageType.text
        case "video":
            self = MessageType.video
        case "photo":
            self = MessageType.photo
        case "audio":
            self = MessageType.audio
        default:
            self = MessageType.text
        }
    }
    
    
}


enum MessageDirection{
    case sent, received
}
