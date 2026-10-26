//
//  AuthField.swift
//  WhatsApp
//
//  Created by Apple on 20/10/2026.
//

import SwiftUI

struct AuthField: View {
    @Binding var text:String
    let type:AuthFieldType
    
    
    var title:String{
        switch type {
        case .email:
           return "Email"
        case .password:
           return "Password"
        case .username:
            return "Username"
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 5){
        Text(title)
            .font(.caption)
            .bold()
        
        HStack {
            Image(systemName: type.imageName)
                .foregroundStyle(.gray)
            
            Group{
                if(type == AuthFieldType.password){
                    
                    SecureField( type.placeHolderText, text: $text)
                }else{
                    TextField(type.placeHolderText ,text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }
            }.keyboardType(type.keyBoardType)
                
        }
        .padding(15)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2),lineWidth: 1)
        }
        }.padding(.horizontal,10)
    }
}

enum AuthFieldType{
    case email, password, username
    
    var placeHolderText:String {
        switch self {
        case .email:
              return "Enter your email"
        case .password:
            return "Enter your password"
        case .username:
            return "Enter your username"
        }
    }
    
    var imageName:String {
        switch self {
        case .email:
              return "envelope.fill"
        case .password:
            return "lock.fill"
        case .username:
            return "person.fill"
        }
    }
    var keyBoardType:UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default :
            return .default
        }
    }
    
}



#Preview {
    AuthField(text: .constant(""), type: .email)
    AuthField(text: .constant(""), type: .password)
    AuthField(text: .constant(""), type: .username)
}
