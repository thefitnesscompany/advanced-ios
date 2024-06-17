//
//  Colors.swift
//  advanced-ios
//
//  Created by Harsh Patel on 07/06/24.
//

import SwiftUI
import UIKit

// MARK: Base color palette materials
/// 1. Base
struct SemanticColor {
    /// dynamic color sets (with dark and light mode)
    
    /// staic color sets (not updating along with color mode)
    let neutral0 = Color("white0")
    let neutral1 = Color("gray100") // FAFAFA, can change to F7F7F8
    let neutral13 = Color("gray1300")
    let neutral9a = Color("gray906")
    
    let inverted0 = Color("gray1400")
    let inverted9a = Color("white906")
}

/// 2. Tokens
struct TokenColor {
    let semanticColor = SemanticColor()
    
    let textPrimary: Color!
    let textSecondary: Color!
    let textPrimaryInverted: Color!
    let textSecondaryInverted: Color!
    
    let iconSecondary: Color!
    
    let backgroundDefault: Color!
    let backgroundInverted: Color!
    
    init() {
        /// text
        self.textPrimary = semanticColor.neutral13
        self.textSecondary = semanticColor.neutral9a
        self.textPrimaryInverted = semanticColor.neutral0
        self.textSecondaryInverted = semanticColor.inverted9a
        
        /// icon
        self.iconSecondary = semanticColor.neutral9a
        
        /// background
        self.backgroundDefault = semanticColor.neutral0
        self.backgroundInverted = semanticColor.inverted0
    }
}

// MARK: Add palatte to Color struct
extension Color {
    static let Token = TokenColor()
}
