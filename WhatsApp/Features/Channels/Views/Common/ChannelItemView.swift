//
//  ChannellIteemView.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//


import SwiftUI
 struct ChannellItemView:View{
    let channel: ChannelItem
    
    var body: some View{
        HStack(alignment: .top) {
            Circle()
                .frame(width: 45,height: 45)
            
            VStack(alignment: .leading) {
                headerTextView()
                
                Text(channel.lastMessage)
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.gray)
                    .lineLimit(2)
               
            }
        }
    }
    
    
    private func headerTextView()->some View{
        
        HStack {
            Text(channel.title)
                .bold()
                .font(.title3)
                .lineLimit(1)
            Spacer()
            
            Text("5:50PM")
                .font(.callout)
                .bold()
                .foregroundStyle(.gray)
        }
        
    }
}
