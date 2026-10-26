//
//  UserNode.swift
//  WhatsApp
//
//  Created by Apple on 25/10/2026.
//

import SwiftUI

struct UserNode{
    let users:[UserItem]
    let cursor: String?
    
    
    static var emptyNode:UserNode{
        return UserNode(users: [],cursor: nil)
    }
    
}
