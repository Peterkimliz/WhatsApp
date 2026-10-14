//
//  ChatRoomScreen.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct ChatRoomScreen: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0..<100) { _ in
                    Text("These are the messages")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.systemGray6))
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
        ChatRoomScreen()
    }
}
