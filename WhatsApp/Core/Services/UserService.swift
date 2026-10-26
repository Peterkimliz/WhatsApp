//
//  UserService.swift
//  WhatsApp
//
//  Created by Apple on 25/10/2026.
//
import Firebase
import SwiftUI



protocol UserManager{
    static var shared:UserManager{ get}
    
    func fetchPaginatedUsers(cursor:String?, pageSize:UInt)async throws ->UserNode
}

final class UserService : UserManager{
  
    
    
    private init() {
        
    }
    
    static let shared: UserManager = UserService()
    
    func fetchPaginatedUsers(cursor: String?, pageSize: UInt) async throws -> UserNode {
        let mainSnapshot:DataSnapshot
        
        if(cursor == nil){
          mainSnapshot  = try await FirebaseConstants.userReference.queryLimited(toLast: pageSize).getData()
        
        }else{
            mainSnapshot = try await FirebaseConstants.userReference
                .queryOrderedByKey()
                .queryEnding(atValue: cursor)
                .queryLimited(toLast: pageSize+1)
                .getData()
        }
        guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
              let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else { return .emptyNode}
        
        let users:[UserItem] = allObjects.compactMap { userSnapshot in
            let userDict = userSnapshot.value as? [String:Any] ?? [:]
            return UserItem(dictionary: userDict)
        }
    
        if(users.count == allObjects.count){
            let filteredUsers = cursor == nil ? users : users.filter({$0.id != cursor})
            
            return UserNode(users: filteredUsers, cursor: first.key)
        }
        
        return .emptyNode
    }
    
    
    
    
    
}
