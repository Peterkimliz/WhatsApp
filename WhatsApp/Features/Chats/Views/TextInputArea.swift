//
//  TextInputArea.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct TextInputArea: View {
    @State private var text = ""
    
    
    var sendButtonDisabled:Bool{
        return text.isWhiteSpaceOrEmpty
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            imagePickerButton()
            audioRecorderButton()
            TextField("write message.", text:$text ,axis: .vertical)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.thickMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5),lineWidth: 1)
                )
            
            
            
            
            chatSendButton()
        }.padding(5)
            .padding([.top],10)
        .background(.whatsAppWhite)
        
        
    }
    
    
    
    private func imagePickerButton()-> some View{
        Button {
        
        } label: {
             Image(systemName: "photo.on.rectangle.fill")
                .font(.system(size: 25))
        }

    }
    
    private func audioRecorderButton()-> some View{
        Button {
        
        } label: {
        Image(systemName: "microphone.fill")
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
            
        }

    }
    
    
    private func chatSendButton()-> some View{
        Button {
        
        } label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .padding(6)
                .background(sendButtonDisabled ? .gray.opacity(0.3) : .blue)
                .clipShape(Circle())
        }.disabled(sendButtonDisabled)

    }
}

#Preview {
    TextInputArea()
}
