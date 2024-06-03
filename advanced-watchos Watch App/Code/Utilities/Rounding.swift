//
//  Rounding.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 31/05/24.
//

import Foundation

struct Rounding {
    static let thousandths = Rounding(specifier: "%.3f")
    static let hundredths = Rounding(specifier: "%.2f")
    static let tenths = Rounding(specifier: "%.1f")
    static let ones = Rounding(specifier: "%.0f")

    var specifierString: () -> String

    private init(specifier: @autoclosure @escaping () -> String) {
        self.specifierString = specifier
    }
}
