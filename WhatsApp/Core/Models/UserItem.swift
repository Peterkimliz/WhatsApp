//
//  UserItem.swift
//  WhatsApp
//
//  Created by Apple on 22/10/2026.
//

import SwiftUI

struct UserItem:Identifiable,Codable{
    let email:String
    let uid:String
    let username:String
    var  bio:String? = nil
    var profileImageUrl :String? = nil
    
    var id : String{
        return uid
    }
    
    var bioUnwrapped:String{
        return bio ?? "Hey there iam using whats app"
    }
    
    
}

extension UserItem{
    static let placeholder = UserItem(email: "peter@gmail.com", uid: UUID().uuidString, username: "Qatester")
    static let usersPlaceHolder = [
        UserItem(email: "petro@gmail.com", uid: UUID().uuidString, username: "Petro Kimani"),
        UserItem(email: "jmes@gmail.com", uid: UUID().uuidString, username: "James Mwangi"),
        UserItem(email: "Hillary@gmail.com", uid: UUID().uuidString, username: "Hillary Jones"),
        UserItem(email: "grace@gmail.com", uid: UUID().uuidString, username: "Grace weru"),
        UserItem(email: "peter@gmail.com", uid: UUID().uuidString, username: "Qatester"),
        UserItem(email: "cathrine@gmail.com", uid: UUID().uuidString, username: "Cathrine Johnson"),
        UserItem(email: "wright@gmail.com", uid: UUID().uuidString, username: "Henry wright"),
        UserItem(email: "wright@gmail.com", uid: UUID().uuidString, username: "Joseph Hims"),
        UserItem(email: "wright@gmail.com", uid: UUID().uuidString, username: "Anderson Straight"),
        UserItem(email: "wright@gmail.com", uid: UUID().uuidString, username: "George Jones"),
        UserItem(email: "wright@gmail.com", uid: UUID().uuidString, username: "Don Williams"),
    
        
    ]
    
    init(dictionary:[String:Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.uid =  dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.bio = dictionary["bio"] as? String? ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String? ?? ""
        
        
    }
}
