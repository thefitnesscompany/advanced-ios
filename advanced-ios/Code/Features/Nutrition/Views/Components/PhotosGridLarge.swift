//
//  PhotosGrid.swift
//  advanced-ios
//
//  Created by Harsh Patel on 05/06/24.
//

import SwiftUI

struct PhotosGridLarge: View {
    let images: [UIImage]
    let rotationAngles: [Double] = [-1, 2.5, 2, -1]
    
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
                            GridItem(.flexible())
                        ]
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 190)
                                .cornerRadius(largeCornerRadius)
                                .rotationEffect(.degrees(rotationAngles[index % rotationAngles.count] + Double.random(in: -1...1)))
                                .onTapGesture {
                                }
                        }
                    }
                    .padding(.top, blurMargin) // to account for the top blur
                    .padding(.bottom, blurMargin) // to account for the bottom blur
                }
                .background(Color.clear)
                .scrollIndicators(.hidden)
                
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
                    
                    PhotosGridLarge(images: [
                        UIImage(imageLiteralResourceName: "test-food-1"),
                        UIImage(imageLiteralResourceName: "test-food-2"),
                        UIImage(imageLiteralResourceName: "test-food-3"),
                        UIImage(imageLiteralResourceName: "test-food-4"),
                        UIImage(imageLiteralResourceName: "test-food-1"),
                        UIImage(imageLiteralResourceName: "test-food-2"),
                        UIImage(imageLiteralResourceName: "test-food-3"),
                        UIImage(imageLiteralResourceName: "test-food-4"),
                        UIImage(imageLiteralResourceName: "test-food-1"),
                        UIImage(imageLiteralResourceName: "test-food-2"),
                        UIImage(imageLiteralResourceName: "test-food-3"),
                        UIImage(imageLiteralResourceName: "test-food-4")
                    ])
                }
                
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
