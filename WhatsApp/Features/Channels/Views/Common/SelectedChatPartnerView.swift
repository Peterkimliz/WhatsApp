//
//  SelectedChatPartnerView.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI

struct SelectedChatPartnerView: View {
    let item:UserItem
    let onTap:(UserItem)->Void
    var body: some View {
        VStack(alignment: .leading){
            Circle()
                .frame(width:60,height: 60)
                .overlay(alignment:.topTrailing) {
                    removeButton()
                }
            
            Text(item.username)
                .bold()
                .font(.caption)
                .lineLimit(1)
            
            
        }.frame(maxWidth: .infinity)
    }
    
    
    private func removeButton()-> some View{
        Button{
            onTap(item)
        }label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .padding(5)
                .foregroundStyle(.white)
                .background(Color(.gray))
                .clipShape(Circle())
        }
        
    }
    
}

#Preview {
    SelectedChatPartnerView(item:.placeholder){ item  in
        
    }
}
