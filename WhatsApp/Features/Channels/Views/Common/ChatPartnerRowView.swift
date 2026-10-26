//
//  ChatPartnerRowView.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI

struct ChatPartnerRowView<Content:View>: View {
    let item:UserItem
    let trailingItem: Content
    
    
    init(item: UserItem, trailingItem: ()->Content = {EmptyView()}) {
        self.item = item
        self.trailingItem = trailingItem()
    }
    
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40,height: 40)
            
            VStack(alignment: .leading){
                Text(item.username)
                    .bold()
                    .font(.title3)
                    .lineLimit(1)
                
                Text(item.bioUnwrapped)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            
            trailingItem
            
        }
    }
}

#Preview {
    ChatPartnerRowView(item:.placeholder) {
        Text("hello")
    }
}
