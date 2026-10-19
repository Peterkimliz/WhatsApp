//
//  BubbleImageView.swift
//  WhatsApp
//
//  Created by Apple on 18/10/2026.
//
import SwiftUI

struct BubbleAudioView: View {
    let messageItem:MessageItem
    @State private var sliderValue:Double = 0
    @State private var sliderValueRange:ClosedRange<Double> = 0...20
    
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                playButton()
                Slider(value: $sliderValue, in:sliderValueRange)
                Text("00:07")
                    .foregroundStyle(.gray)
                
            }
            .padding(10)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            dateAndReadImage()
        }
      
        .padding(4)
        .background(messageItem.background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .applyTrailingTail(direction: messageItem.direction)
        .padding(.leading, messageItem.direction == .sent ? 100 : 5)
        .padding(.trailing, messageItem.direction == .sent ? 5 : 100)
        .frame(maxWidth: .infinity,alignment: messageItem.horizontalAlignment)
    }
    

    
    private func playButton()-> some View{
     
        Image(systemName: "play.fill")
                .padding(10)
                .foregroundStyle(messageItem.direction == .sent ? .black : .white)
                .background(messageItem.direction == .sent ? .white : .green)
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
        
        BubbleAudioView(messageItem: .messagesStubs[4])
        BubbleAudioView(messageItem: .messagesStubs[5])
    }
    .background(Color.gray.opacity(0.1))
}
