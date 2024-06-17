//
//  TestContainer.swift
//  advanced-ios
//
//  Created by Harsh Patel on 09/06/24.
//

import SwiftUI

struct DummyContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.red.opacity(0.1)
            .overlay {
                content
            }
    }
}

#Preview {
    TestContainerPreview()
}

struct TestContainerPreview: View {
    var body: some View {
        DummyContainer {
            NavigationStack {
                DummyContainer {
                    VStack(alignment: .center) {
                        DummyContainer {
                            Text("Hello World!!")
                        }
                        
                        Spacer()
                        
                        DummyContainer {
                            HStack(alignment: .center) {
                                DummyContainer {
                                    Text("Hello")
                                }
                                DummyContainer {
                                    Text("World")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
