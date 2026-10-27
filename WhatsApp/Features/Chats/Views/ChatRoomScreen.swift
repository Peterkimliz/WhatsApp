//
//  ChatRoomScreen.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel:ChannelItem
    var body: some View {
        ZStack{
            Image(.chatbackground)
                .resizable()
            
            ScrollView(showsIndicators: false){
                ForEach(MessageItem.messagesStubs) { item    in
                    
                    switch item.type{
                    case .text:
                        BubbleTextView(messageItem: item)
                    case .photo, .video:
                        BubbleImageView(messageItem: item)
                    case .audio:
                        BubbleAudioView(messageItem: item)
                    }
                }
                
                
            }
            
        }.safeAreaInset(edge: .bottom, content: {
            TextInputArea()
        })
        .toolbar(.hidden, for:.tabBar)
        .toolbar {
            toolBarLeading()
            toolBarTrailing()
        }
    }
}



private extension ChatRoomScreen{
    
    @ToolbarContentBuilder
    private func toolBarLeading()->some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            HStack{
                Circle()
                    .frame(width: 30,height: 30)
                
                Text("Qauser 1")
                    .font(.headline)
                    .bold()
                    .fixedSize(horizontal: true, vertical: false)
                
            }
        }.sharedBackgroundVisibility(.hidden)
    }
    @ToolbarContentBuilder
    
    private func toolBarTrailing()->some ToolbarContent{
        ToolbarItemGroup(placement: .topBarTrailing, ) {
            Button {
                
            } label: {
                Image(systemName: "video")
            }
            
            Button {
                
            } label: {
                Image(systemName: "phone")
            }

        }.sharedBackgroundVisibility(.hidden)
    }
    
    
    
}

#Preview {
    NavigationStack{
        ChatRoomScreen(channel: .channelItem)
    }
}
