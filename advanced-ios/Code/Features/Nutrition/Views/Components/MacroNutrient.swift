//
//  MacroNutrient.swift
//  advanced-ios
//
//  Created by Harsh Patel on 09/06/24.
//

import SwiftUI

struct MacroNutrient: View {
    let macroLabel: String
    let macroValue: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(macroValue)
                .font(Font.Typography.headerSmall)
//                .foregroundStyle(.green)
            
            Text(macroLabel)
                .font(Font.Typography.body)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MacroNutrient(macroLabel: "Low Cal", macroValue: "100")
}
