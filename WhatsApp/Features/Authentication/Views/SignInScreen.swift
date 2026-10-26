//
//  SignInScreen.swift
//  WhatsApp
//
//  Created by Apple on 20/10/2026.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var vm = AuthViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading,spacing:20){
                Spacer()
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading,10)
                
            
                AuthField(text: $vm.loginEmail, type: .email)
               
                AuthField(text: $vm.loginPassword, type: .password)
                Button{
                    
                }label: {
                    Text("Forgot Password ?")
                        .font(.callout)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.trailing,10)
                }
                
                
                AuthButton(message: "Sign In") {
                    Task{
                       await vm.handleLogin()
                        
                    }
            
                }.disabled(vm.loginButtonDisabled)
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
                
                
                NavigationLink {
                    SignUpScreen()
                        .environment(vm)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .bold()
                    }
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                        .padding(.bottom,10)
                }
        
            }.overlay{
                if(vm.loggingIn){
                    ProgressView {
                        Text("Logging in ...")
                    }
                }
            }
            .alert("Error While Signing In",
                   isPresented: $vm.loginErrorState.showError) {
                
            } message: {
                Text(vm.loginErrorState.message)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
    }
}

#Preview {
    SignInScreen()
}
