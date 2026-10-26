//
//  WhatsAppApp.swift
//  WhatsApp
//
//  Created by Apple on 06/10/2026.
//
import SwiftUI
import FirebaseCore
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
      FirebaseApp.configure()
      Database.database().isPersistenceEnabled = true
        Database.database().reference().keepSynced(true)

      return true
    }
}




@main
struct WhatsAppApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            
            RootScreen()
        }
    }
}
