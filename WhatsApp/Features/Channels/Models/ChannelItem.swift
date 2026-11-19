//
//  ChannelItem.swift
//  WhatsApp
//
//  Created by Apple on 17/11/2026.
//

import SwiftUI
import FirebaseAuth

struct ChannelItem:Identifiable{
    var id:String
    var name:String?
    var lastMessage:String
    var lastMessageTimestamp:Date
    var creationTimestamp:Date
    var thumbnail:String?
    var adminUid:[String]
    var memberUids:[String]
    var memberCount:Int
    var isDirectChannel:Bool
    var owner:String
    var members:[UserItem]
    
    private var membersExcludeMe:[UserItem]{
        guard let currentUserId = Auth.auth().currentUser?.uid else { return []}
        return members.filter{$0.id != currentUserId }
    }
    
    var title:String{
        if let name = name{
            return name
        }else{
            if isDirectChannel{
                return membersExcludeMe.first?.username ?? "Unknown"
                
            }else{
                return "Grouo Message"
            }
        }
    }
}

extension ChannelItem{
    
    static let placeholder = ChannelItem(
        id: UUID().uuidString,
        lastMessage: "Hello There",
        lastMessageTimestamp: Date(),
        creationTimestamp: Date(),
        adminUid: [],
        memberUids: [],
        memberCount: 2,
        isDirectChannel: true,
        owner: UUID().uuidString,
        members: []
    )
    
    init(dict:[String:Any]){
        self.id = dict[.channelId] as? String ?? ""
        self.name = dict[.channelName] as? String? ?? nil
        self.lastMessage = dict[.channelLastMessage] as? String ?? ""
        let lastMessageTime = dict[.channelLastMessageTimestamp] as? Double ?? 0
        self.lastMessageTimestamp = Date(timeIntervalSince1970: lastMessageTime)
        let creationDate = dict[.channelLastMessageTimestamp] as? Double ?? 0
        self.creationTimestamp = Date(timeIntervalSince1970: creationDate)
        self.thumbnail = dict[.channelThumbnail] as? String? ?? nil
        self.adminUid = dict[.channelAdminUid] as? [String] ?? []
        self.memberUids = dict[.channelMemberUids] as? [String] ?? []
        self.memberCount = dict[.channelMemberCount] as? Int ?? 0
        self.isDirectChannel = dict[.channelIsDirectChannel] as? Bool ?? false
        self.owner = dict[.channelOwner] as? String ?? ""
        self.members = dict[.channelMembers] as? [UserItem] ?? []
        
    }
}


extension String {
    static let channelName = "name"
    static let channelId = "id"
    static let channelLastMessage = "lastMessage"
    static let channelLastMessageTimestamp = "lastMessageTimestamp"
    static let channelCreationTimestamp = "creationTimestamp"
    static let channelThumbnail = "thumbnail"
    static let channelAdminUid = "adminUid"
    static let channelMemberUids = "memberUids"
    static let channelMemberCount = "memberCount"
    static let channelIsDirectChannel = "isDirectChannel"
    static let channelOwner = "owner"
    static let channelMembers = "members"
}
