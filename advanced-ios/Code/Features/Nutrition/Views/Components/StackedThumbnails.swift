//
//  StackedThumbnails.swift
//  advanced-ios
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct StackedThumbnails: View {
    @Binding var photos: [String]
    
    var body: some View {
        ZStack {
            ForEach(Array(photos.enumerated()), id: \.offset) { index, photo in
                Image(photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .cornerRadius(8)
                    .rotationEffect(Angle(degrees: [-10, -25, 15][index % 3]))
                    .overlay(
                       RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 0)
                    )
                    .zIndex(Double(photos.count - index))
            }
        }
    }
}

#Preview {
    StackedThumbnailsPreview()
}

struct StackedThumbnailsPreview: View {
    @State var photos: [String] = ["test-food-1", "test-food-2", "test-food-3"]
    
    var body: some View {
        StackedThumbnails(photos: $photos)
    }
}
