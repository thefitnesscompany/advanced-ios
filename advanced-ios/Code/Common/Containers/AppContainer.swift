//
//  AppContainer.swift
//  advanced-ios
//
//  Created by Harsh Patel on 08/06/24.
//

import SwiftUI

struct AppContainer<Content: View>: View {
    let bgColor: Color
    let content: Content
    
    init(bgColor: Color = Color.Token.backgroundDefault, @ViewBuilder content: () -> Content) {
        self.bgColor = bgColor
        self.content = content()
    }
    
    var body: some View {
        self.bgColor
            .ignoresSafeArea()
            .overlay {
                content
            }
    }
}

#Preview {
    AppContainerPreview()
}

struct AppContainerPreview: View {
    var body: some View {
        AppContainer {
            NavigationStack {
                AppContainer {
                    VStack(alignment: .center) {
                        Text("Hello World!!")
                    }
                    .padding(50)
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(.white))
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
