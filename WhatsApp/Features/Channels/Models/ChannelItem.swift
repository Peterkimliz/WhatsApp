//
//  ChannelItem.swift
//  WhatsApp
//
//  Created by Apple on 29/10/2026.
//

import SwiftUI
import  FirebaseAuth

struct ChannelItem:Identifiable{
    var id:String
    var name:String?
    var thumbNail:String?
    var lastMessage:String
    var lastMessageTimeStamp:Date
    var creationTimeStamp:Date
    var owner:String
    var membersUids:[String]
    var adminsUids:[String]
    var membersCount:Int
    var isDirectMessage:Bool
    var members:[UserItem]
    
    var memmbersExceptMe:[UserItem]{
        guard let currentUserId = Auth.auth().currentUser?.uid else{ return [] }
        return members.filter {$0.id != currentUserId}
        
    }
    
    var title:String{
        if let name = name {
            return name
        }
        else {
            if(isDirectMessage){
                return memmbersExceptMe.first?.username ?? ""
            }
            else{
                return "Group Chat"
            }
            
        }
    }
    
}


extension ChannelItem{
    
    
    init(dictionary:[String:Any]){
        self.id = dictionary[.channelId] as? String ?? ""
        self.name = dictionary[.channelName] as? String? ?? nil
        self.thumbNail = dictionary[.channelThumbNail] as? String? ?? nil
        self.lastMessage = dictionary[.channelLastMessage] as? String ?? ""
        let lastMessageTime = dictionary[.channelLastMessageTimeStamp] as? Double ?? 0
        self.lastMessageTimeStamp = Date(timeIntervalSince1970: lastMessageTime)
        let creationTime = dictionary[.channelCreationTimeStamp] as? Double ?? 0
        self.creationTimeStamp = Date(timeIntervalSince1970: creationTime)
        self.owner = dictionary[.channelOwner] as? String ?? ""
        self.membersUids = dictionary[.channelMembersUids] as? [String] ?? []
        self.adminsUids = dictionary[.channelAdminsUids] as? [String] ?? []
        self.membersCount = dictionary[.channelMembersCount] as? Int ?? 0
        self.isDirectMessage = dictionary[.channelIsDirectMessage ] as? Bool ?? false
        self.members = dictionary[.channelMembers] as? [UserItem] ?? []
    }
    
    
    static let channelItem = ChannelItem(
        id: UUID().uuidString,
        lastMessage: "Hello There",
        lastMessageTimeStamp: Date(),
        creationTimeStamp: Date(),
        owner: UUID().uuidString,
        membersUids: [],
        adminsUids: [],
        membersCount: 2,
        isDirectMessage: true,
        members: []
    )
    
}

extension String{
    static let channelId = "id"
    static let channelName = "name"
    static let channelThumbNail = "thumbNail"
    static let channelLastMessage = "lastMessage"
    static let channelLastMessageTimeStamp = "lastMessageTimeStamp"
    static let channelCreationTimeStamp = "creationTimeStamp"
    static let channelOwner = "owner"
    static let channelMembersUids = "membersUids"
    static let channelAdminsUids = "adminsUids"
    static let channelMembersCount = "membersCount"
    static let channelIsDirectMessage = "isDirectMessage"
    static let channelMembers = "members"
}
