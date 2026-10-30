//
//  ChatPartnerPickerScreen.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    @State private var chatPartnerPickerVm = ChatPartnerPickerViewModel()
    var onChannelCreation: (ChannelItem)->Void
    
    
    var body: some View {
        NavigationStack(path:$chatPartnerPickerVm.navStack){
            List{
                ForEach(ChatPartnerPickerOption.allCases){ item in
                    Button{
                        guard item == ChatPartnerPickerOption.newGroup else { return}
                        chatPartnerPickerVm.navStack.append(.addGroupMembers)
                    }label: {
                        chatPartnerPickerItem(item: item)
                    }
                    
                }
                
                
                Section {
                    if(chatPartnerPickerVm.users.isEmpty){
                        ContentUnavailableView("No Users were found", systemImage: "book.fill")
                            .listRowBackground(Color.clear)
                    }
                    else{
                        ForEach(chatPartnerPickerVm.users){ item  in
                            
                            
                            Button{
                                chatPartnerPickerVm.createDirectChannel(user: item) { channel in
                                    onChannelCreation(channel)}
                                
                                }label: {
                                ChatPartnerRowView(item: item)
                            }
                            
                            
                            
                        }
                    }
                    
                }header: {
                    Text("Contacts On WhatsApp")
                }
                
                if(chatPartnerPickerVm.paginatable){
                    ProgressView()
                        .frame(maxWidth: .infinity,alignment: .center)
                        .task {
                            await chatPartnerPickerVm.fetchUsers()
                        }
                    
                    
                }
                
                
            }.navigationTitle("New Chat")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text:$searchText,placement:.toolbarPrincipal)
                .toolbar {
                    cancelButton()
                }
            
                .onAppear{
                    chatPartnerPickerVm.selectedChatPartners.removeAll()
                }
                .navigationDestination(for: ChannelCreationRoute.self) { route in
                    
                    switch route{
                    case .addGroupMembers:
                        GroupMemberSelectionScreen()
                            .environment(chatPartnerPickerVm)
                    case .setUpGroup:
                        NewGroupSetUpScreen{channel in
                            onChannelCreation(channel)
                        }
                            .environment(chatPartnerPickerVm)
                    }
                    
                    
                    
                }
        }
    }
}

extension ChatPartnerPickerScreen{
    
    private func chatPartnerPickerItem(item:ChatPartnerPickerOption)-> some View{
        HStack {
            Image(systemName:item.icon)
                .font(.footnote)
                .frame(width: 30,height: 30)
                .padding(3)
                .background(Color(.systemGray5))
                .clipShape(Circle())
            
            Text(item.title)
                .bold()
        }
    }
    
    
    private func cancelButton()->some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                dismiss()
                
            }label: {
                Image(systemName: "xmark")
                    .font(.footnote)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }.sharedBackgroundVisibility(.hidden)
        
    }
    
    private enum ChatPartnerPickerOption:String, Identifiable,CaseIterable {
        case newGroup = "New Group"
        case newContact = "New Contact"
        case newCommunity = "New Community"
        
        
        var id :String{
            return rawValue
        }
        var title:String{
            return rawValue
        }
        
        var icon:String{
            switch self {
            case .newGroup:
                return "person.2.fill"
            case .newContact:
                return "person.badge.plus.fill"
            case .newCommunity:
                return "person.3.fill"
            }
        }
    }
    
    
    
}




#Preview {
    ChatPartnerPickerScreen { item in
        
    }
}
