//
//  SignUpScreen.swift
//  WhatsApp
//
//  Created by Apple on 20/10/2026.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthViewModel.self)  var vm:AuthViewModel
    
    
    var body: some View {
        @Bindable var authVm = vm
        
        NavigationStack{
            VStack(alignment: .leading,spacing:20){
                Spacer()
                Text("Create Your Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading,10)
                
                AuthField(text: $authVm.registerEmail, type: .email)
                AuthField(text: $authVm.registerUsername, type: .username)
                AuthField(text: $authVm.registerPassword, type: .password)
                AuthButton(message: "Sign Up") {
                    
                }.disabled(authVm.registerButtonDisabled)
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 1)

                    Text("Or Continue with ")
                        .bold()
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)

                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 1)
                }.frame(maxWidth: .infinity)
                .padding(10)
                
                HStack{
                    SocialButton(type: .apple) {
                        
                    }
                    SocialButton(type: .google) {
                        
                    }
                }.frame(maxWidth: .infinity)
                
                Spacer()
                
                Button {
                   dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                        Text("Sign In")
                            .bold()
                    }.font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom,10)
                }
                
            }
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
    }
}

#Preview {
    SignUpScreen()
}
