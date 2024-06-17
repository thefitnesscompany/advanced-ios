//
//  DayWiseView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 05/06/24.
//

import SwiftUI

struct DayWiseView: View {
    @Binding var activeView: PresenterView.ActiveView
    
    let images: [UIImage]
    let rotationAngles: [Double] = [-10, -25, 15]
        
    var body: some View {
        AppContainer {
            VStack(alignment: .leading) {
                    let summary = Text("You've had")
                    .foregroundStyle(Color.Token.textSecondary)
                    + Text(" 1229 calories")
                    .foregroundStyle(Color.Token.textPrimary)
                    + Text(",")
                    .foregroundStyle(Color.Token.textSecondary)
                    + Text(" 43g of protein")
                    .foregroundStyle(Color.Token.textPrimary)
                    + Text(",")
                    .foregroundStyle(Color.Token.textSecondary)
                    + Text(" 75g of fats")
                    .foregroundStyle(Color.Token.textPrimary)
                    + Text(", and")
                    .foregroundStyle(Color.Token.textSecondary)
                    + Text(" 109g of carbs")
                    .foregroundStyle(Color.Token.textPrimary)
                    + Text(". Try to avoid foods with high carbs to balance out the rest of your day.")
                    .foregroundStyle(Color.Token.textSecondary)
                
                summary
                    .font(Font.Typography.headerSmall)
                    .lineSpacing(1.5)
                    .padding(.bottom, 8)
                
                PhotosGridLarge(images: images)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.top)
            
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        activeView = .camera
                    } label: {
                        Image(systemName: "button.programmable")
                            .imageScale(.large)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        activeView = .monthly
                    } label: {
                        Image(systemName: "circle.grid.3x3.fill")
                            .imageScale(.medium)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                }
                
                ToolbarItem(placement: .status) {
                    Text("Today, Jun 5")
                        .font(Font.Typography.bodyEmphasized)
                        .foregroundStyle(Color.Token.textPrimary)
                }
            }
        }
    }
}

#Preview {
    DayWiseViewPreview()
}

struct DayWiseViewPreview: View {
    @State var activeView: PresenterView.ActiveView = .daily
    
    var body: some View {
        DayWiseView(
            activeView: $activeView,
            images: [
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-3")
            ]
        )
    }
}
