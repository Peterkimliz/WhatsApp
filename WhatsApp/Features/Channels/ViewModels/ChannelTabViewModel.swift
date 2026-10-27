//
//  ChannelTabViewModel.swift
//  WhatsApp
//
//  Created by Apple on 27/10/2026.
//

import SwiftUI

@Observable
final class ChannelTabViewModel{
    var showChatPartnerPicker = false
    var channel:ChannelItem?
    var navigateToChatScreen:Bool = false
    
    
    func onChannelCreation(channelItem:ChannelItem){
        showChatPartnerPicker = false
        channel = channelItem
        navigateToChatScreen = true
        
    }
    
}
