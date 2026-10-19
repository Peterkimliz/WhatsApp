//
//  BubbleImageView.swift
//  WhatsApp
//
//  Created by Apple on 18/10/2026.
//

import SwiftUI

struct BubbleImageView: View {
    let messageItem:MessageItem
    var body: some View {
        
        
        HStack{
            
            if(messageItem.direction == .sent){
                Spacer()
            }
            
            
            HStack{
                if(messageItem.direction == .sent){
                    
                    shareButton()
                }
                
                imageAndTextView()
                    .overlay {
                        playButton()
                            .opacity( messageItem.type == .video ? 1 : 0)
                    }
                
                if(messageItem.direction == .received){
                    
                    shareButton()
                }
            }
            
            if(messageItem.direction == .received){
                Spacer()
            }
        
        
        }.padding(.leading, messageItem.direction == .sent ? 100 : 5)
        .padding(.trailing, messageItem.direction == .sent ? 5 : 100)
        .frame(maxWidth: .infinity,alignment: messageItem.horizontalAlignment)
    }
    
    
    private func imageAndTextView()->some View{
        VStack(alignment: .leading){
            Image(.stubImage0)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            HStack{
                Text(messageItem.message)
                    .font(.system(size: 14))
                Spacer()
                dateAndReadImage()
            }
            
        }
        .padding(6)
        .background(messageItem.background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .applyTrailingTail(direction: messageItem.direction)
        
    }
    
    private func shareButton()-> some View{
        Button {
            
        } label: {
            Image(systemName: "arrowshape.turn.up.forward.fill")
                .padding(10)
                .foregroundStyle(.white)
                .background(Color(.systemGray3))
                .clipShape(Circle())
        }

        
    }
    
    private func playButton()-> some View{
     
        Image(systemName: "play.fill")
                .padding(10)
                .foregroundStyle(.white)
                .background(Color(.systemGray4))
                .clipShape(Circle())
    

        
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
    
    ScrollView {
        
        BubbleImageView(messageItem: .messagesStubs[4])
        BubbleImageView(messageItem: .messagesStubs[5])
    }
    .background(Color.gray)
}
