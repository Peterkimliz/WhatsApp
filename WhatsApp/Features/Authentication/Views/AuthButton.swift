//
//  AuthButton.swift
//  WhatsApp
//
//  Created by Apple on 20/10/2026.
//

import SwiftUI

struct AuthButton: View {
    let message:String
    let onTap: ()->Void
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
        Button{
            onTap()
        }label: {
            HStack{
                Text(message)
                Image(systemName:"arrow.forward")
        
            }.frame(maxWidth: .infinity)
            .padding(10)
            .background(isEnabled ? .green : .gray.opacity(0.2))
            .clipShape( RoundedRectangle(cornerRadius: 10, style:.continuous))
            .foregroundStyle(.white)
            .bold()
            .padding()
            .shadow(color:.gray.opacity(0.3),radius: 8)
            
            
        }
    }
}

#Preview {
    AuthButton(message: "Sign In"){
        
    }
}
