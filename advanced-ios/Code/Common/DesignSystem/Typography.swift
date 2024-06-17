//
//  Typography.swift
//  advanced-ios
//
//  Created by Harsh Patel on 07/06/24.
//

import SwiftUI

// MARK: Base typography materials
struct TokenTypography {
    // 1. Prepare base materials
    private enum FontFamily: String {
        case
        sfPro = "SFProText",
        monaSans = "MonaSans-Regular"
    }
    
    enum FontFamilyToken: String {
        case
        system,
        main
        
        func getValue() -> String {
            switch self {
            case .system:
                return FontFamily.sfPro.rawValue
            case .main:
                return FontFamily.monaSans.rawValue
            }
        }
    }
    
    // 2. Expose data
    let headerMedium: Font!
    let headerSmall: Font!
    let body: Font!
    let bodyEmphasized: Font!
    let caption: Font!
    
    init(fontFamily: FontFamilyToken) {
        if fontFamily == .system {
            self.headerMedium = Font.system(.title2, design: .rounded, weight: .semibold)
            self.headerSmall = Font.system(.title3, design: .rounded, weight: .medium)
            self.body = Font.system(.body, design: .rounded, weight: .regular)
            self.bodyEmphasized = Font.system(.body, design: .rounded, weight: .semibold)
            self.caption = Font.system(.caption, design: .rounded, weight: .regular)
        } else {
            self.headerMedium = Font.custom(fontFamily.getValue(), size: UIFont.preferredFont(forTextStyle: .title2).pointSize).weight(.semibold)
            self.headerSmall = Font.custom(fontFamily.getValue(), size: UIFont.preferredFont(forTextStyle: .title3).pointSize).weight(.medium)
            self.body = Font.custom(fontFamily.getValue(), size: UIFont.preferredFont(forTextStyle: .body).pointSize).weight(.regular)
            self.bodyEmphasized = Font.custom(fontFamily.getValue(), size: UIFont.preferredFont(forTextStyle: .body).pointSize).weight(.medium)
            self.caption = Font.custom(fontFamily.getValue(), size: UIFont.preferredFont(forTextStyle: .caption1).pointSize).weight(.regular)
        }
    }
}

// MARK: Helper functions
extension TokenTypography {
    public func sizingFont(font: FontFamilyToken, size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return Font.custom(font.getValue(), size: size).weight(weight)
    }
}

// MARK: Expose Typography to Font struct
extension Font {
    static let SystemTypography = TokenTypography(fontFamily: .system)
    static let Typography = TokenTypography(fontFamily: .main)
}
