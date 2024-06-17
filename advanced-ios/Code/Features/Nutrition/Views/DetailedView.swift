//
//  PhotoDetailsView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 05/06/24.
//

import SwiftUI

struct DetailedView: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            BlurredImageBackground(image: image)
            
            VStack(alignment: .leading, spacing: 0) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 450)
                    .cornerRadius(largeCornerRadius)
                    .padding(.top, 20)
                    .padding(.bottom, 44)
                
                Text("Samosas")
                    .font(Font.Typography.headerMedium)
                    .foregroundStyle(Color.Token.textPrimaryInverted)
                
                let description = Text("Whole-grain pancakes can be a delicious way to eat more whole grains that offer several health benefits.")
                
                description
                    .font(Font.Typography.body)
                    .foregroundStyle(Color.Token.textSecondaryInverted)
                    .padding(.top, 12)
                
                HStack(alignment: .center, spacing: 5) {
                    Text("Today")
                    
                    Text(".")
                    
                    Text("Information is sourced from website results")
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(Font.Typography.caption)
                .foregroundStyle(Color.Token.textSecondaryInverted)
                .padding(.top, 24)
                
                Spacer()
                
                HStack(alignment: .center) {
                    MacroNutrient(macroLabel: "Low Cal", macroValue: "100")
                    
                    MacroNutrient(macroLabel: "Protein", macroValue: "2g")
                    
                    MacroNutrient(macroLabel: "Carbs", macroValue: "12.75")
                    
                    MacroNutrient(macroLabel: "Fat", macroValue: "3.67g")
                }
                .font(Font.Typography.body)
                .foregroundStyle(Color.Token.textSecondaryInverted)
                .padding(.top, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DetailedView(image: UIImage(imageLiteralResourceName: "test-food-3"))
}
