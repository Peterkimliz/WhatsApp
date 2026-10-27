//
//  ChannelItem.swift
//  WhatsApp
//
//  Created by Apple on 27/10/2026.
//

import SwiftUI

struct ChannelItem: Identifiable{
    var id:String
    var name:String?
    var lastMessage:String
    var lastMessageTimeStamp:Date
    var creationDate:Date
    var thumbNail:String?
    var adminsUids:[String]
    var membersUids:[String]
    var isGroup:Bool
    var membersCount:UInt
    let member:[UserItem]
    
}

extension ChannelItem{
    
    static let channelItem = ChannelItem(
            id: UUID().uuidString,
            lastMessage: "Hello Ther",
            lastMessageTimeStamp:Date(),
            creationDate: Date(),
            adminsUids:[],
            membersUids:[],
            isGroup: false,
            membersCount: 2,
            member:[]
        )
    
    
}
