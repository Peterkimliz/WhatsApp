//
//  BubbleTrailingView.swift
//  WhatsApp
//
//  Created by Apple on 17/10/2026.
//

import SwiftUI

struct BubbleTrailingView: View {
    let direction:MessageDirection
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .resizable()
            .renderingMode(.template)
            .frame(width: 10,height: 10)
            .foregroundStyle( direction == .sent ? .bubbleGreen : .bubbleWhite)
            .offset(y:2)
    }
}

#Preview {
    
    ScrollView{
        BubbleTrailingView(direction: .sent)
        BubbleTrailingView(direction: .received)
    }.frame(maxWidth: .infinity)
        .background(.gray.opacity(0.3))
}
