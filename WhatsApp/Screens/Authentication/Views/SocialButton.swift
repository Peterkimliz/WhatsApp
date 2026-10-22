//
//  SocialButton.swift
//  WhatsApp
//
//  Created by Apple on 22/10/2026.
//

import SwiftUI

struct SocialButton: View {
    let type:SocialType
    let onTap:()->Void
    var body: some View {
        
        Button{
            onTap()
        }label: {
            HStack(spacing: 3){
                
                Image(type.icon)
                    .resizable()
                      
                    .frame(width: 20,height: 20)
                Text("\(type.title)")
                    .foregroundStyle(.whatsAppBlack)
                
                
            }
            
            .padding(12)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow( color: .gray.opacity(0.3),radius: 10)
            .padding(10)
            
        }
        
        
    }
}

enum SocialType{
    case google, apple
    
    var title:String{
        switch self {
        case .google:
            return "Google"
        case .apple:
            return "Apple"
        }
    }
    var icon:String{
        switch self {
        case .google:
            return "google-logo"
        case .apple:
            return "apple-logo"
        }
    }
    
}


#Preview {
    SocialButton(type: .apple){
        
    }
}
