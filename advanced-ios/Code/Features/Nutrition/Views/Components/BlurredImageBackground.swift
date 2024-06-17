//
//  TestView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 09/06/24.
//

import SwiftUI

struct BlurredImageBackground: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 0)
                .fill(Color.black.opacity(0.85))
                .ignoresSafeArea()
                .background(Material.ultraThin)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BlurredImageBackground(image: UIImage(imageLiteralResourceName: "test-food-3"))
}
