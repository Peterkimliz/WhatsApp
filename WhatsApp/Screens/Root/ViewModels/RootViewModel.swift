//
//  RootViewModel.swift
//  WhatsApp
//
//  Created by Apple on 23/10/2026.
//

import SwiftUI
import Combine

@Observable
final class  RootViewModel{
    var authState = AuthState.pending
    
    var cancellable : AnyCancellable?
    
    
    init() {
      handleAuthentication()
    }
    
    
   private func handleAuthentication() {
      cancellable =  AuthService.shared.authState
            .receive(on: DispatchQueue.main)
            .sink { newAuthState in
            self.authState = newAuthState
        }
    }
    
}
