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
    
    init(dictionary:[String:Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.uid =  dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.bio = dictionary["bio"] as? String? ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String? ?? ""
        
        
    }
}
