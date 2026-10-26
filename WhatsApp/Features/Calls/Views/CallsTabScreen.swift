//
//  CallsTabScreen.swift
//  WhatsApp
//
//  Created by Apple on 07/10/2026.
//

import SwiftUI

struct CallsTabScreen: View {
    @State private var searchText:String  = ""
    @State private var selectedCallHistoryOption:CallHistoryOptions = .all
    
    var body: some View {
        NavigationStack {
            
            List {
                Section {
                    CallLinkView()
                }
                
                
                Section {
                    ForEach(0..<10) { _ in
                        RecentCallItem()
                    }
                    
                }header: {
                    Text("Recent")
                        .foregroundStyle(.whatsAppBlack)
                }
                
                
                
            }.navigationTitle("Calls")
                .searchable(text: $searchText,placement:.toolbarPrincipal)
            
            .toolbar {
                leadingToolBarItem()
                principalToolBarItem()
                trailingToolBarItem()
                
            }
            
        }
    }
    
}


extension CallsTabScreen{
    
    @ToolbarContentBuilder
    private func leadingToolBarItem()-> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Button {
                
            } label: {
                Text("Edit")
            }

        }
    }
    
    
    
    @ToolbarContentBuilder
    private func principalToolBarItem()-> some ToolbarContent{
        ToolbarItem(placement: .principal) {
           
            
            Picker("", selection: $selectedCallHistoryOption) {
                ForEach(CallHistoryOptions.allCases) { item in
                    Text(item.rawValue.capitalized)
                        .tag(item)
                }
                
            }.pickerStyle(.segmented)
        }
    }
    
    
    
    
    @ToolbarContentBuilder
    private func trailingToolBarItem()-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: "phone.arrow.up.right.fill")
            }

        }
    }
    
    
    private enum CallHistoryOptions:String, CaseIterable,Identifiable{
        case all
        case missed
        
        var id:String{
            return rawValue
        }
    
    }
}



private struct CallLinkView:View{

    var body: some View{
        HStack {
            Image(systemName: "link")
                .padding(8)
                .foregroundStyle(.blue)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            
            
            VStack (alignment: .leading){
                Text("Create Call Link")
                    .foregroundStyle(.blue)
                
                Text("Share a link for your WhatsApp call")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        
    }
    
}


private struct RecentCallItem: View{
    
    var body: some View{
        
        HStack {
            Circle()
                .frame(width: 50,height: 50)
            callInfo()
            Spacer()
            
            Text("Yesterday")
                .font(.system(size: 16))
                .foregroundStyle(.gray)
            
            Image(systemName: "info.circle")
            
            
        }
    
    }
    
    
    private func callInfo()-> some View{
        VStack(alignment: .leading){
            
            Text("John Doe")
            
            HStack {
                Image(systemName: "phone.arrow.up.right.fill")
                Text("Outgoing")
                
                
            }.font(.caption)
            .foregroundStyle(.gray)
        }
    }
    
    
    
    
}


#Preview {
    CallsTabScreen()
}
