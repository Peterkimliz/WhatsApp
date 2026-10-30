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
}

enum MessageDirection{
    case sent, received
}
