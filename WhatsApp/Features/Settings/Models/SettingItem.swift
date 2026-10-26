//
//  SettingItems.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct SettingItem{
    let name:String
    let background:Color
    let image:String
    var imageType:ImageType = .system
    
    enum ImageType{
        case system
        case photo
    }
    
}



extension SettingItem{
    
    static let profile:SettingItem =  SettingItem(name: "Change Profile Picture", background: .blue, image: "photo")
    static let broadcast:SettingItem =  SettingItem(name: "Broadcast List", background: .green, image: "speaker.zzz.fill")
    static let starred:SettingItem =  SettingItem(name: "Starred Messages", background: .yellow, image: "star.fill")
    static let linked:SettingItem =  SettingItem(name: "Linked Devices", background: .green, image: "laptopcomputer")
    
    
    static let help:SettingItem =  SettingItem(name: "Help", background: .blue, image: "info")
    static let chat:SettingItem =  SettingItem(name: "Chats", background: .green, image: "whatsapp-black",imageType: .photo)
    static let friend:SettingItem =  SettingItem(name: "Tell a Friend", background: .red, image: "suit.heart.fill")
    static let privacy:SettingItem =  SettingItem(name: "Privacy", background: .cyan, image: "lock.fill")
    static let notification:SettingItem =  SettingItem(name: "Notification", background: .red, image: "bell.badge.fill")
    static let storage:SettingItem =  SettingItem(name: "Storage & Data", background: .green, image: "arrow.up.arrow.down")
    static let account:SettingItem =  SettingItem(name: "Account", background: .blue, image: "key.fill")
   
}
