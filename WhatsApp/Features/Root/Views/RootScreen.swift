//
//  RootScreen.swift
//  WhatsApp
//
//  Created by Apple on 23/10/2026.
//

import SwiftUI

struct RootScreen: View {
    @State private var vm = RootViewModel()
    var body: some View {
        
        switch vm.authState{
        case .pending:
            ProgressView()
            
            
        case .loggedIn(let user):
            MainTabView()
        case .loggedOut:
            SignInScreen()
    
        }
    }
}

#Preview {
    RootScreen()
}
