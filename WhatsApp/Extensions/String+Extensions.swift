//
//  String+Extension.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//

import SwiftUI

extension String{
    
    var isWhiteSpaceOrEmpty:Bool{
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    
}
