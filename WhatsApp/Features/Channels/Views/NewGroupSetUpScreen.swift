//
//  NewGroupSetUpScreen.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI

struct NewGroupSetUpScreen: View {
    @Environment(ChatPartnerPickerViewModel.self) private var vm
    var onCreation:(ChannelItem)->Void
    
    
    var body: some View {
        @Bindable var vmBindable = vm
        
        List{
            
            Section{
                HStack{
                    Image(systemName: "camera")
                        .foregroundStyle(.blue)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                    
                    TextField("Group Name ", text: $vmBindable.channelName,axis: .vertical )
                }
            }
            
            Section{
                Text("Disappearing Messages")
                Text("Group Permissions")
            }
            
            
            Section{
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(vm.selectedChatPartners) { item in
                            SelectedChatPartnerView(item: item) { selectedUser in
                                vm.handleChatPartnerSelection(item: selectedUser)
                                
                            }
                            
                        }
                    }
                }
            }header: {
                Text("Participants:\(vm.selectedChatPartners.count) of \(vm.maxGroupUser)")
                
            }.listRowBackground(Color.clear)
            
            
            
            
        }.navigationTitle("New Group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingToolBarItem()
            }
        
    }
}


extension NewGroupSetUpScreen{
    
    @ToolbarContentBuilder
    private func trailingToolBarItem()->some ToolbarContent{
        
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                
                vm.createGroupChannel(channelName: vm.channelName) { channel in
                    onCreation(channel)
                }
                
            }label: {
                Text("Create")
                    .bold()
            }.disabled( vm.createButtodDisabled)
        }.sharedBackgroundVisibility(.hidden)
    }
    
}



#Preview {
    NavigationStack{
        NewGroupSetUpScreen {channelItem in
            
        }
    }
}
