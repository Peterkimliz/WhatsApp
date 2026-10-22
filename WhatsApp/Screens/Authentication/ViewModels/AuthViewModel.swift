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
    
    var registerEmail:String = ""
    var registerPassword:String = ""
    var registerUsername:String = ""
    
    
    var loginButtonDisabled:Bool{
        return  loginEmail.isWhiteSpaceOrEmpty || loginPassword.isWhiteSpaceOrEmpty
        
    }
    var registerButtonDisabled:Bool{
        return  registerEmail.isWhiteSpaceOrEmpty || registerPassword.isWhiteSpaceOrEmpty || registerUsername.isWhiteSpaceOrEmpty
        
    }
    
    
}
