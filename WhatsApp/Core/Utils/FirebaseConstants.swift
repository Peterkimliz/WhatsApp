//
//  FirebaseConstants.swift
//  WhatsApp
//
//  Created by Apple on 25/10/2026.
//

import SwiftUI
import FirebaseDatabase



enum FirebaseConstants{
    static var DataBaseReference = Database.database().reference()
    static var userReference = DataBaseReference.child("users")
        
    
    
}
