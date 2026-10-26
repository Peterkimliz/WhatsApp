//
//  ChatPartnerPickerViewModel.swift
//  WhatsApp
//
//  Created by Apple on 24/10/2026.
//

import SwiftUI
import FirebaseAuth

enum ChannelCreationRoute{
    case addGroupMembers
    case setUpGroup
}

@Observable
final class ChatPartnerPickerViewModel{
    var navStack = [ChannelCreationRoute]()
    let maxGroupUser = 20
    var name:String = ""
    
    var lastCursor:String?
    var selectedChatPartners = [UserItem]()
    var users = [UserItem]()
    
    var paginatable:Bool{
        return !users.isEmpty
    }
    
    
    
    init(){
        Task{
            await fetchUsers()
        }
    }
    
    var showSelectedChatPartners:Bool{
        return !selectedChatPartners.isEmpty
    }
    
    var nextButtodDisabled:Bool{
        return selectedChatPartners.isEmpty
    }
    
    var createButtodDisabled:Bool{
        return selectedChatPartners.isEmpty || name.isWhiteSpaceOrEmpty
    }
    
    
    func handleChatPartnerSelection(item:UserItem){
        if isUserSelected(user: item){
            guard let index = selectedChatPartners.firstIndex(where: {$0.id == item.id }) else{ return}
            selectedChatPartners.remove(at:index)
        }else{
            selectedChatPartners.append(item)
        }
        
        
    }
    
    
    func isUserSelected(user:UserItem)->Bool{
        return selectedChatPartners.contains {$0.id == user.id}
    }
    
    
    
    
    
    func fetchUsers()async{
        do{
            let userNode = try await UserService.shared.fetchPaginatedUsers(cursor: lastCursor, pageSize: 5)
            let filteredUsers = userNode.users.filter {$0.id != Auth.auth().currentUser?.uid}
            self.users.append(contentsOf: filteredUsers)
            self.lastCursor = userNode.cursor
            
            print("Current cursor \(String(describing: lastCursor))")
            
        }catch{
            print("error occurrred is \(error.localizedDescription)")
        }
        
    }
    
    
    
}
