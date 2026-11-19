//
//  ChatRoomScreen.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel:ChannelItem
    @State private var viewModel:ChatroomViewModel
    
    init(channel: ChannelItem) {
        self.channel = channel
        _viewModel = State(wrappedValue: ChatroomViewModel(channel: channel))
    }
    
    
    var body: some View {
        ZStack{
            Image(.chatbackground)
                .resizable()
            
            ScrollView(showsIndicators: false){
                ForEach(viewModel.messages) { item   in
                    
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
            TextInputArea(textMessage: $viewModel.textMessage) {
                viewModel.sendMessage()
            }
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
                
                Text(channel.title)
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
        ChatRoomScreen(channel: .placeholder)
    }
}
