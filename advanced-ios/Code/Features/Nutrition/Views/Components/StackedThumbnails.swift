//
//  StackedThumbnails.swift
//  advanced-ios
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct StackedThumbnails: View {
    @Binding var photos: [UIImage]
    let rotationAngles: [Double] = [-10, -25, 15]
    
    var body: some View {
        ZStack {
            ForEach(Array(photos.enumerated()), id: \.offset) { index, photo in
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .cornerRadius(smallCornerRadius)
                    .rotationEffect(Angle(degrees: rotationAngles[index % rotationAngles.count]))
                    .zIndex(Double(photos.count - index))
            }
        }
    }
}

#Preview {
    StackedThumbnailsPreview()
}

struct StackedThumbnailsPreview: View {
    @State var photos: [UIImage] = [
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3")
    ]
    
    var body: some View {
        StackedThumbnails(photos: $photos)
    }
}
