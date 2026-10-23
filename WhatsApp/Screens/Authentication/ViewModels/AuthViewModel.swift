//
//  AuthViewModel.swift
//  WhatsApp
//
//  Created by Apple on 22/10/2026.
//

import SwiftUI

@Observable
class AuthViewModel{
   
    var loginEmail:String = ""
    var loginPassword:String = ""
    var loggingIn:Bool = false
    var loginErrorState:(message:String, showError:Bool) = ("", false)
    
    var registerEmail:String = ""
    var registerPassword:String = ""
    var signingUp:Bool = false
    var registerUsername:String = ""
  
    var registerErrorState:(message:String, showError:Bool) = ("", false)
    
    
    var loginButtonDisabled:Bool{
        return  loginEmail.isWhiteSpaceOrEmpty || loginPassword.isWhiteSpaceOrEmpty
        
    }
    var registerButtonDisabled:Bool{
        return  registerEmail.isWhiteSpaceOrEmpty || registerPassword.isWhiteSpaceOrEmpty || registerUsername.isWhiteSpaceOrEmpty
        
    }
    
    
    
   func  handleLogin()async{
       loggingIn = true
       defer{
           loggingIn = false
       }
       do{
           try await AuthService.shared.signInUser(with: loginEmail, and: loginPassword)
           
       }catch{
           loginErrorState.message = error.localizedDescription
           loginErrorState.showError = true
           
           print("The error is \(error.localizedDescription)")
       }
       
       
   }
    
    func handleSignUp()async{
        signingUp = true
       defer{
           signingUp = false
       }
       do{
           try await AuthService.shared.signUpUser(for: registerUsername, with: registerEmail, and: registerPassword)
           
       }catch{
           registerErrorState.message = error.localizedDescription
           registerErrorState.showError = true
           
           print("The error is \(error.localizedDescription)")
       }
       
   }
     func handleSignOut()async{
       do{
           
           try await AuthService.shared.signOutUser()
           
       }catch{
           print("The error is \(error.localizedDescription)")
       }
       
   }
    
    
    
    
}
