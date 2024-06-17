//
//  TestView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 09/06/24.
//

import SwiftUI

struct TestView: View {
    @State private var showDetailView: Bool = false

    var body: some View {
        PinchAnimationView()
    }
}

// MARK: PinchAnimationView
struct PinchAnimationView: View {
    @State private var scale: CGFloat = 1.0
    @State private var isViewAVisible = true

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isViewAVisible {
                    CView()
//                        .scaleEffect(min(max(scale, 1.0), 1.5))
//                        .transition(.push(from: .top))
//                        .transition(.opacity)
//                        .transition(.opacity)
                        .transition(.scale(1.2, anchor: .topLeading).combined(with: .opacity))
//                        .opacity(Double(min(max(scale, 0.8), 1.0)))
//                        .animation(.easeInOut(duration: 1.0))
                } else {
                    DView()
//                        .transition(.opacity)
//                        .scaleEffect(min(max(scale, 0.9), 1))
//                        .scaleEffect(max(min(scale, 1.0), 0.8))
                        .transition(.scale(1.2, anchor: .bottomTrailing).combined(with: .opacity))
//                        .transition(.push(from: .top))
//                        .opacity(Double(max(min(scale, 1.2), 1.0)))
//                        .animation(.easeInOut(duration: 1.0))
                }
            }
            .gesture(MagnificationGesture()
                .onChanged { value in
                    if isViewAVisible {
                        if value < 0.8 {
                            withAnimation(.easeIn(duration: 0.5)) {
                                isViewAVisible = false
                            }
                        }
                    } else {
                        if value > 1.2 {
                            withAnimation(.easeIn(duration: 0.5)) {
                                isViewAVisible = true
                            }
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation {
//                        scale = 1.0
                    }
                }
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct CView: View {
    var images: [UIImage] = [
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3"),
        UIImage(imageLiteralResourceName: "test-food-4"),
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3"),
        UIImage(imageLiteralResourceName: "test-food-4")
    ]
    
    var body: some View {
        Color.Token.backgroundDefault
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 20) {
                    PhotosGridLarge(images: images)
                }
                .ignoresSafeArea()
                .font(Font.Typography.headerSmall)
                .foregroundColor(Color.Token.textPrimary)
            )
    }
}

struct DView: View {
    var images: [UIImage] = [
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
        UIImage(imageLiteralResourceName: "test-food-4"),
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
    ]
    
    var body: some View {
        Color.Token.backgroundDefault
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 10) {
                    PhotosGridSmall(images: images)
                }
                .ignoresSafeArea()
                .font(Font.Typography.headerSmall)
                .foregroundColor(Color.Token.textPrimary)
            )
    }
}

// MARK: SlideAnimation
struct SlideAnimationView: View {
    @State private var showDetailView: Bool = false
    
    var body: some View {
        if !showDetailView {
            AView(showDetailView: $showDetailView)
        } else {
            BView(showDetailView: $showDetailView)
        }
    }
}

struct AView: View {
    @Binding var showDetailView: Bool
    
    var body: some View {
//        Color.red
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
                VStack {
                    Text("A View")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color.blue).opacity(0.5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                showDetailView = true
                            }
                        }
                }
                .transition(.push(from: .bottom))
//            )
    }
}

struct BView: View {
    @Binding var showDetailView: Bool
    
    var body: some View {
//        Color.blue
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
                VStack {
                    Text("B View")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color.blue).opacity(0.5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                showDetailView = false
                            }
                        }
                }
                .transition(.push(from: .bottom))
//            )
    }
}

#Preview {
    TestView()
}
