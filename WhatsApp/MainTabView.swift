//
//  MainTabView.swift
//  WhatsApp
//
//  Created by Apple on 06/10/2026.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            Tab(
                TabViewItems.updates.title,
                systemImage: TabViewItems.updates.icon
            ) {
                UpdateTabScreen()
            }
            
            Tab(
                TabViewItems.calls.title,
                systemImage: TabViewItems.calls.icon
            ) {
                CallsTabScreen()
            }
            
            Tab(
                TabViewItems.communities.title,
                systemImage: TabViewItems.communities.icon
            ) {
               CommunitesTabScreen()
            }
            
            Tab(
                TabViewItems.chats.title,
                systemImage: TabViewItems.chats.icon
            ) {
                ChannellTabScreen()
            }
            
            Tab(
                TabViewItems.settings.title,
                systemImage: TabViewItems.settings.icon
            ) {
                SettingsTabScreen()
            }
            
            
        }
        
        
    }
}



extension MainTabView{
    
    private enum TabViewItems:String{
        case updates
        case calls
        case communities
        case chats
        case settings
        
        
        var title : String{
            return rawValue.capitalized
        }
        
        
        var icon: String {
            
            switch self {
            case .updates:
                return "inset.filled.circle.dashed"
            case .calls:
               return "phone.fill"
            case .communities:
                return "person.3.fill"
            case .chats:
               return  "message.fill"
            case .settings:
                return "gear"
            }
        }
    }
    
}

#Preview {
    MainTabView()
}
