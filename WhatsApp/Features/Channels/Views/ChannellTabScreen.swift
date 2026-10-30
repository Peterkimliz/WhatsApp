//
//  ChannellTabScreen.swift
//  WhatsApp
//
//  Created by Apple on 08/10/2026.
//

import SwiftUI

struct ChannellTabScreen: View {
    @State private var searchText:String = ""
    @State private var vm = ChannelTabViewModel()
    var body: some View {
        NavigationStack{
            List{
                
                Label("Archived", systemImage: "archivebox.fill")
                    .foregroundStyle(.gray)
                    .bold()
                    .listRowSeparator(.hidden)
                    .padding([.leading],10)
                
                
                ForEach(vm.channels){ channel in
                    
                    
                    NavigationLink {
                        ChatRoomScreen(channel:channel)
                    } label: {
                        ChannellItemView(channel: channel)
                    }

                    
                }
                
                
                footNote()
                    .listRowSeparator(.hidden)
                
                
            }.navigationTitle("Chats")
            .listStyle(.plain)
            .searchable(text: $searchText,placement:.toolbarPrincipal)
            .animation(.easeInOut, value: vm.navigateToChatScreen)
            .sheet(isPresented:$vm.showChatPartnerPicker){
                ChatPartnerPickerScreen(onChannelCreation: vm.onChannelCreation)
            }
            .navigationDestination(isPresented: $vm.navigateToChatScreen, destination: {
                if let channel = vm.channel{
                    ChatRoomScreen(channel: channel)
                }
            })
            .toolbar {
                leadingMenuItem()
                
                trailingToolBarItems()
                
            }
        }
    }
    
}



private extension ChannellTabScreen{
    
    @ToolbarContentBuilder
    private func leadingMenuItem()->some ToolbarContent{
    
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle.fill")
                }

            } label: {
                Image(systemName: "ellipsis.circle")
            }

            
        }.sharedBackgroundVisibility(.hidden)
    }
    
    
    @ToolbarContentBuilder
    private func trailingToolBarItems()->some ToolbarContent{
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: "camera")
            }
            
            Button {
                vm.showChatPartnerPicker = true
            } label: {
                Image(.plus)
            }

            
        }.sharedBackgroundVisibility(.hidden)
        
        
    }
    
    
    private func footNote()-> some View{
        
        HStack{
            
            Image(systemName: "lock.fill")
            Text("Your personal message are")
            Text("end-to-end encrypted")
                .foregroundStyle(.blue)
            
        }.font(.caption)
        .bold()
        .foregroundStyle(.gray)
        .padding([.leading],15)
    }
    
}

#Preview {
    ChannellTabScreen()
}
