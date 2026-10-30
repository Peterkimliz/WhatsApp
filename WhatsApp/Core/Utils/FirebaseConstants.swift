//
//  FirebaseConstants.swift
//  WhatsApp
//
//  Created by Apple on 25/10/2026.
//

import SwiftUI
import FirebaseDatabase



enum FirebaseConstants{
    static var DataBaseReference = Database.database().reference()
    static var userReference = DataBaseReference.child("users")
    
    static var ChannelRef = DataBaseReference.child("channels")
    static var ChannelMessages = DataBaseReference.child("channel-messages")
    static var ChannelUsers = DataBaseReference.child("channel-users")
    static var directChannels = DataBaseReference.child("direct-channels")
        
    
    
}
