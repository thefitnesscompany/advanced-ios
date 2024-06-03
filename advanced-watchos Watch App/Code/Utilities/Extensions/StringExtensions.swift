//
//  StringExtensions.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 29/05/24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
