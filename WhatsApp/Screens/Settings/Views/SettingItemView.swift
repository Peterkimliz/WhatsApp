//
//  SettingItemView.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

struct SettingItemView: View {
    let item:SettingItem
    var body: some View {
        HStack{
            imageView()
                .frame(width: 30, height:30)
                .padding(5)
                .foregroundStyle(.white)
                .background(item.background)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Text(item.name.capitalized)
                .font(.title3)
                .bold()
            
            
            
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func imageView()-> some View{
        
        switch item.imageType{
        case .photo :
            Image(item.image)
                .renderingMode(.template)
            
        case .system:
            Image(systemName: item.image)
        }
    }
}

#Preview {
    SettingItemView(item:.chat)
}
