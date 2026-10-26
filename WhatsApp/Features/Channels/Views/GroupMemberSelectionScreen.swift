//
//  GroupMemberSelectionScreen.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI

struct GroupMemberSelectionScreen: View {
    @State private var searchText = ""
    @Environment(ChatPartnerPickerViewModel.self) private var vm
    
    var body: some View {
        List{
            
            if(vm.showSelectedChatPartners){
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
                }
            }
            
            
            if(vm.users.isEmpty){
                ContentUnavailableView("No Users were found", systemImage: "book.fill")
                    .listRowBackground(Color.clear)
            }
            else{
                ForEach(vm.users) { item in
                    Button{
                        vm.handleChatPartnerSelection(item: item)
                    }label: {
                        let image:String  = vm.isUserSelected(user: item) ? "checkmark.circle.fill" : "circle"
                        let imageColor:Color = vm.isUserSelected(user: item) ? Color.blue : .gray
                        
                        ChatPartnerRowView(item: item) {
                            Image(systemName: image)
                                .foregroundStyle(imageColor)
                                .imageScale(.large )
                            
                        }
                    }
                    
                }
            }
            
            if(vm.paginatable){
                ProgressView()
                    .frame(maxWidth: .infinity,alignment: .center)
                    .task {
                        await vm.fetchUsers()
                    }
                
                
            }
            
            
            
        }.navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text:$searchText,placement:.toolbarPrincipal)
            .toolbar {
                principalToolBar()
                trailingToolBar()
            }.animation(.easeInOut, value: vm.showSelectedChatPartners)
    }
    
}



extension   GroupMemberSelectionScreen{
    @ToolbarContentBuilder
    private func trailingToolBar()->some ToolbarContent{
        ToolbarItem (placement: .topBarTrailing){
            Button{
                vm.navStack.append(.setUpGroup)
            }label: {
                Text("Next")
                    .bold()
            }
            .disabled(vm.nextButtodDisabled)
            
        }.sharedBackgroundVisibility(.hidden)
        
    }
    
    @ToolbarContentBuilder
    private func principalToolBar()->some ToolbarContent{
        ToolbarItem (placement: .principal){
            VStack {
                Text("Add Participant")
                    .bold()
                
                Text("\(vm.selectedChatPartners.count)/\(vm.maxGroupUser )")
                    .foregroundStyle(.gray)
            }
        }.sharedBackgroundVisibility(.hidden)
        
    }
    
}



#Preview {
    
    NavigationStack{
        GroupMemberSelectionScreen()
    }
}
