//
//  SettingsTabScreen.swift
//  WhatsApp
//
//  Created by Apple on 08/10/2026.
//

import SwiftUI

struct SettingsTabScreen: View {
    var body: some View {
        NavigationStack{
            List{
                SettingsHeader()
                
                Section{
                    SettingItemView(item: .broadcast)
                    SettingItemView(item: .starred)
                    SettingItemView(item: .linked)
                }
                Section{
                    SettingItemView(item: .account)
                    SettingItemView(item: .privacy)
                    SettingItemView(item: .chat)
                    SettingItemView(item: .notification)
                    SettingItemView(item: .storage)
                }
                Section{
                    SettingItemView(item: .help)
                    SettingItemView(item: .friend)
              
                    
                    
                    HStack{
                        Image(systemName: "iphone.and.arrow.forward")
                            .resizable()
                            .frame(width: 20, height:20)
                            .foregroundStyle(.red)

                        Text("Sign Out")
                            .font(.title3)
                            .foregroundStyle(.red)
                            .bold()
                        
                      
                    }
                    
                
                }
                
            }.navigationTitle("Settings")
        }
    }
    
    
    
}

private struct SettingsHeader:View{
    
    var body: some View{
        Section{
            
            HStack(alignment: .top){
                Circle()
                    .frame(width: 45,height: 45)
                userInfoDetails()
                
            }
            Button {
                
            } label: {
                SettingItemView(item: .profile)
            }

           
            
        }
    }
    
    private func userInfoDetails()->some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("Qatester 1")
                    .bold()
                    .font(.title3)
                Spacer()
                
                Image(.qrcode)
                    .renderingMode(.template)
                    .foregroundStyle(.blue)
                    .padding(5)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
            
            Text("Hey there iam using Whatsapp!")
                .bold()
                .font(.callout)
                .foregroundStyle(.gray)
            
            
        }
        
    }
    
}




#Preview {
    SettingsTabScreen()
}
