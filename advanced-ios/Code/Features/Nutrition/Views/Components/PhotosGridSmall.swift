//
//  PhotosGridSmall.swift
//  advanced-ios
//
//  Created by Harsh Patel on 05/06/24.
//

import SwiftUI

struct PhotosGridSmall: View {
    let images: [UIImage]
    
    let blurColor: Color = Color.Token.backgroundDefault
    let blurMargin: CGFloat = 24
    let blurMinValue: CGFloat = 0
    let blurMaxValue: CGFloat = 0.9
    
    var body: some View {
        AppContainer {
            ZStack {
                ScrollView {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(Array(images.enumerated()), id: \.offset) { _, image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .cornerRadius(mediumCornerRadius)
                        }
                    }
                    .padding(.top, blurMargin) // to account for the top blur
                    .padding(.bottom, blurMargin) // to account for the bottom blur
                }
                .scrollIndicators(.hidden)
                .defaultScrollAnchor(.bottom)
                
                VStack {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                blurColor.opacity(blurMaxValue),
                                blurColor.opacity(blurMinValue)
                            ]),
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: blurMargin)
                    Spacer()
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                blurColor.opacity(blurMinValue),
                                blurColor.opacity(blurMaxValue)
                            ]),
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: blurMargin)
                }
            }
        }
    }
}

#Preview {
    AppContainer {
        NavigationStack {
            AppContainer {
                VStack {
                    Text("Some Header")
                    
                    PhotosGridSmall(
                        images: [
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3"),
                            UIImage(imageLiteralResourceName: "test-food-4"),
                            UIImage(imageLiteralResourceName: "test-food-1"),
                            UIImage(imageLiteralResourceName: "test-food-2"),
                            UIImage(imageLiteralResourceName: "test-food-3")
                    ])
                }
                .padding(.horizontal)
                
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack(alignment: .center) {
                            Button(action: {}, label: {
                                Text("Button")
                            })
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .safeAreaPadding()
    }
}
