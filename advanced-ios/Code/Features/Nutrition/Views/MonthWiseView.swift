//
//  MonthWiseView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 05/06/24.
//

import SwiftUI

struct MonthWiseView: View {
    @Binding var activeView: PresenterView.ActiveView
    
    let images: [UIImage]
    
    var body: some View {
        AppContainer {
            VStack(alignment: .leading) {
                let summary = Text("You've had an average of")
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
                + Text(" each day of this month.")
                    .foregroundStyle(Color.Token.textSecondary)
                
                summary
                    .font(Font.Typography.headerSmall)
                    .lineSpacing(1.5)
                    .padding(.bottom, 8)
                
                PhotosGridSmall(images: images)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            .padding(.horizontal, 24)
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(alignment: .center) {
                        Button {
                            activeView = .camera
                        } label: {
                            Image(systemName: "button.programmable")
                                .imageScale(.large)
                                .foregroundStyle(Color.Token.iconSecondary)
                                .opacity(0.3)
                        }
                        
                        Spacer()
                        
                        Text("Jun 2024")
                            .font(Font.Typography.bodyEmphasized)
                        
                        Spacer()
                        
                        Button {
                            activeView = .daily
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .imageScale(.large)
                                .foregroundStyle(Color.Token.iconSecondary)
                                .opacity(0.3)
                        }
                    }
                    .font(.system(.title3, design: .rounded, weight: .medium))
                }
            }
        }
    }
}

#Preview {
    MonthWiseViewPreview()
}

struct MonthWiseViewPreview: View {    
    @State var activeView: PresenterView.ActiveView = .monthly
    
    var body: some View {
        MonthWiseView(
            activeView: $activeView,
            images: [
            UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-4"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-2"),
                UIImage(imageLiteralResourceName: "test-food-1"),
                UIImage(imageLiteralResourceName: "test-food-3"),
                UIImage(imageLiteralResourceName: "test-food-2")
            ]
        )
    }
}
