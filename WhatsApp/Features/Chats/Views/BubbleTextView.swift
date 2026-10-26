//
//  BubbleTextView.swift
//  WhatsApp
//
//  Created by Apple on 17/10/2026.
//

import SwiftUI

struct BubbleTextView: View {
    let messageItem:MessageItem
    
    var body: some View {
        VStack(alignment: .trailing,spacing:2){
            
            Text(messageItem.message)
                .font(.system(size: 14))
            
            dateAndReadImage()
        }
        .padding(10)
        .background(messageItem.background)
        .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
        .applyTrailingTail(direction: messageItem.direction)
        .padding(.leading, messageItem.direction == .sent ? 100 : 5)
        .padding(.trailing, messageItem.direction == .sent ? 5 : 100)
        .frame(maxWidth: .infinity,alignment: messageItem.horizontalAlignment)
    }
    
    
    private func dateAndReadImage()->some View{
        HStack() {
            Text("3:35PM")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
            
            if(messageItem.direction == .sent){
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color(.systemBlue))
                    .bold()
            }
            
        }
    }
    
}

#Preview {
    ScrollView{
        BubbleTextView(messageItem: .messagesStubs[0])
        BubbleTextView(messageItem: .messagesStubs[1])
        
    }.frame(maxWidth: .infinity)
    .background(.gray.opacity(0.3))

}
