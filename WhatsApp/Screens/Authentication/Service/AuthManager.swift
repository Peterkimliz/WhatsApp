//
//  AuthManager.swift
//  WhatsApp
//
//  Created by Apple on 22/10/2026.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine

enum AuthState{
    case pending, loggedIn(UserItem), loggedOut
}

enum AuthErrors:Error, LocalizedError{
    case failedToSignIn(message:String), failedToSignUp(message:String), failedToSaveUserToDatabase(message:String), failedToSignOut(message:String)
    
    var errorDescription: String?{
        switch self {
        case .failedToSignIn(let message):
            return message
        case .failedToSignUp(let message):
            return message
        case .failedToSaveUserToDatabase(let message):
            return message
        case .failedToSignOut(let message):
            return message
        }
    }
    
}



protocol AuthManager{
    static var shared:AuthManager{ get}
    var authState: CurrentValueSubject<AuthState,Never>{ get }
    func signInUser(with email:String, and password:String) async throws
    func signUpUser(for username:String, with email:String, and password:String) async throws
    func signUpUsingGoogle() async throws
    func signOutUser() async throws
    func autoLoginUser() async 


}



final class AuthService : AuthManager{
   
    
    private init(){
        Task{
            await autoLoginUser()
        }
    }
    
    static let shared: AuthManager = AuthService()
    
    var  authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func signInUser(with email: String, and password: String) async throws {
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            fetchUserData()
            print("🔐 successfully signed in to your account")
        }catch{
            print("🔐 Failed to sign in to your account \(error.localizedDescription)")
            throw AuthErrors.failedToSignIn(message: error.localizedDescription)
            
        }
        
    }
    
    
    
    func signUpUser(for username: String, with email: String, and password: String) async throws {
        do{
          let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
          let uid = authResult.user.uid
          let user = UserItem(email: email, uid: uid, username: username)
          try await saveUserInfoToDatabase(user: user)
          authState.send(AuthState.loggedIn(user))
        }catch{
            print("🔐 Failed to create account with \(email) coz of \(error.localizedDescription)")
            throw AuthErrors.failedToSignUp(message: error.localizedDescription)
        }
        
    }
    
    
    func signUpUsingGoogle() async throws {
        
       
    }
    
    
    
    func signOutUser() async throws {
        do{
           try  Auth.auth().signOut()
            authState.send(AuthState.loggedOut)
            
        }catch{
            print("🔐 Failed to log out of the account \(error.localizedDescription)")
            throw AuthErrors.failedToSignOut(message: error.localizedDescription)
        }
        
    }
    
    
    
    func autoLoginUser() async  {
        if Auth.auth().currentUser?.uid == nil{
            authState.send( AuthState.loggedOut)
        }else{
            fetchUserData()
        }
        
    }
   
}



extension AuthService{
    
    private func saveUserInfoToDatabase(user:UserItem)async throws{
        do{
            let userDict : [String : Any] = [
                "uid":user.id,
                "email": user.email,
                "username": user.username,
                "bio": user.bio as Any,
                "profileImageUrl":user.profileImageUrl as Any
            ]
           try await Database.database().reference().child("users").child(user.id).setValue(userDict)
        }catch{
            print("🔐 Failed to save user info to database  \(error.localizedDescription)")
            throw AuthErrors.failedToSaveUserToDatabase(message: error.localizedDescription)
        }
    }
        
    
    private func fetchUserData(){
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        Database.database().reference().child("users").child(uid).observe(.value) {[weak self]snapshot in
            guard let userDictionary = snapshot.value as? [String:Any] else { return }
            let user = UserItem(dictionary: userDictionary)
            self?.authState.send(AuthState.loggedIn(user))
            
        } withCancel: {error in
            print("🔐 Failed to get user  \(error.localizedDescription)")
            
        }
    }
    
    
}
