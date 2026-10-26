//
//  View+Extensions.swift
//  WhatsApp
//
//  Created by Apple on 15/10/2026.
//

import SwiftUI



private struct BubbleTrailingViewModifier: ViewModifier{
    let direction:MessageDirection
    func body(content: Content) -> some View {
        
        content.overlay(alignment: direction == .sent ? .bottomTrailing : .bottomLeading) {
            BubbleTrailingView(direction: direction)
        }
        
    }
}


extension View{
    
    
    func applyTrailingTail(direction:MessageDirection) -> some View{
        self.modifier(BubbleTrailingViewModifier(direction: direction))
    }
    
    
    
    
}
