//
//  FinalTestView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 12/06/24.
//

import SwiftUI

class AppState: ObservableObject {
    enum ActiveView {
        case cam, daily, monthly, detail
    }
    @Published var currentView: ActiveView
    @Published var previousView: ActiveView?
    
    init() {
        currentView = .cam
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct FinalTestView: View {
    @StateObject var appState = AppState()
    @Namespace private var animation
    let image = UIImage(imageLiteralResourceName: "test-food-1")
    
    var body: some View {
        if appState.currentView == .cam {
            CamView(appState: appState, namespace: animation)
        } else if appState.currentView == .daily {
            DayView(appState: appState, namespace: animation)
        } else if appState.currentView == .monthly {
            MonthView(appState: appState, namespace: animation)
        } else if appState.currentView == .detail {
            DetailView(image: image, namespace: animation, appState: appState)
        }
    }
}

struct CamView: View {
    @ObservedObject var appState: AppState
    let namespace: Namespace.ID
    
    @State var images: [UIImage] = [
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3")
    ]
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Group {
                    Color.Token.backgroundDefault.ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.black.opacity(appState.currentView == .cam ? 0.85 : 0))
                        .ignoresSafeArea()
                        .background(Material.ultraThin)
                }
                
                VStack(spacing: 0) {
                    Image(uiImage: UIImage(imageLiteralResourceName: "test-food-1"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 600)
                        .padding(.top, 50)
                        .offset(y: appState.currentView == .cam ? 0 : -1000)
                    
                    ZStack {
                        CameraCaptureButton { }
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack {
                            StackedThumbnails(photos: $images)
                                .padding(.leading, 20)
                                .onTapGesture {
                                    withAnimation(.smooth(duration: 0.8)) {
                                        appState.previousView = .cam
                                        appState.currentView = .daily
                                    }
                                }
                                .matchedGeometryEffect(id: "thumbnails", in: namespace)
                            
                            Spacer()
                        }
                    }
                    .opacity(appState.currentView == .cam ? 1 : 0)
                    .blur(radius: appState.currentView == .cam ? 0 : 10)
                    .padding([.horizontal, .bottom], 20)
                    .padding(.top, 40)
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
        }
    }
}

struct DayView: View {
    var images: [UIImage] = [
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3"),
        UIImage(imageLiteralResourceName: "test-food-4"),
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2")
    ]
    @ObservedObject var appState: AppState
    let namespace: Namespace.ID
        
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
//                    .blur(radius: appState.currentView == .daily ? 0 : 30)
//                    .offset(y: appState.currentView == .daily ? 0 : 200)
//                    .scaleEffect(appState.currentView == .daily ? 1 : 0.5)
                    .blur(radius: appState.currentView == .cam ? 30 : 0)
                    .offset(y: appState.currentView == .cam ? 200 : 0)
                    .scaleEffect(appState.currentView == .cam ? 0.5 : 1)
                
                PhotosGridLarge(images: images)
                    .matchedGeometryEffect(id: "thumbnails", in: namespace)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.8)) {
                            appState.previousView = .daily
                            appState.currentView = .detail
                        }
                    }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Button {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .daily
                            appState.currentView = .cam
                        }
                    } label: {
                        Image(systemName: "button.programmable")
                            .imageScale(.large)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                    
                    Spacer()
                    
                    Text("Today, Jun 5")
                        .font(Font.Typography.bodyEmphasized)
                        .foregroundStyle(Color.Token.textPrimary)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .daily
                            appState.currentView = .monthly
                        }
                    } label: {
                        Image(systemName: "circle.grid.3x3.fill")
                            .imageScale(.medium)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .blur(radius: appState.currentView == .cam ? 30 : 0)
                .offset(y: appState.currentView == .cam ? 30 : 0)
            }
            .scenePadding()
            .gesture(MagnificationGesture()
                .onChanged { value in
                    if value < 0.8 {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .daily
                            appState.currentView = .monthly
                        }
                    }
                }
            )
        }
    }
}

struct MonthView: View {
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
        UIImage(imageLiteralResourceName: "test-food-4"),
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2"),
        UIImage(imageLiteralResourceName: "test-food-3"),
        UIImage(imageLiteralResourceName: "test-food-4"),
        UIImage(imageLiteralResourceName: "test-food-1"),
        UIImage(imageLiteralResourceName: "test-food-2")
    ]
    @ObservedObject var appState: AppState
    let namespace: Namespace.ID
    
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
//                    .blur(radius: appState.currentView == .monthly ? 0 : 30)
//                    .offset(y: appState.currentView == .monthly ? 0 : 200)
//                    .scaleEffect(appState.currentView == .monthly ? 1 : 0.5)
                
                PhotosGridSmall(images: images)
                    .scaleEffect(appState.currentView == .monthly ? 1 : 5, anchor: .bottomTrailing)
//                    .offset(x: appState.currentView == .monthly ? 0 : -500, y: appState.currentView == .monthly ? 0 : -800)
                    .blur(radius: appState.currentView == .monthly ? 0 : 30)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Button {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .monthly
                            appState.currentView = .cam
                        }
                    } label: {
                        Image(systemName: "button.programmable")
                            .imageScale(.large)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                    
                    Spacer()
                    
                    Text("This Month, Jun 2024")
                        .font(Font.Typography.bodyEmphasized)
                        .foregroundStyle(Color.Token.textPrimary)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .monthly
                            appState.currentView = .daily
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(Color.Token.iconSecondary)
                            .opacity(0.3)
                    }
                    .font(Font.Typography.headerSmall)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .blur(radius: appState.currentView == .cam ? 30 : 0)
                .offset(y: appState.currentView == .cam ? 30 : 0)
            }
            .scenePadding()
            .gesture(MagnificationGesture()
                .onChanged { value in
                    if value > 1.5 {
                        withAnimation(.smooth(duration: 0.8)) {
                            appState.previousView = .monthly
                            appState.currentView = .daily
                        }
                    }
                }
            )
        }
    }
}

struct DetailView: View {
    let image: UIImage
    let namespace: Namespace.ID
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            BlurredImageBackground(image: image)
            
            VStack(alignment: .leading, spacing: 0) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 450)
                    .cornerRadius(largeCornerRadius)
                    .padding(.top, 20)
                    .padding(.bottom, 44)
                    .matchedGeometryEffect(id: "thumbnails", in: namespace)
                    .onTapGesture {
                        withAnimation {
                            appState.previousView = .detail
                            appState.currentView = .daily
                        }
                    }
                
                Text("Samosas")
                    .font(Font.Typography.headerMedium)
                    .foregroundStyle(Color.Token.textPrimaryInverted)
                
                let description = Text("Whole-grain pancakes can be a delicious way to eat more whole grains that offer several health benefits.")
                
                description
                    .font(Font.Typography.body)
                    .foregroundStyle(Color.Token.textSecondaryInverted)
                    .padding(.top, 12)
                
                HStack(alignment: .center, spacing: 5) {
                    Text("Today")
                    
                    Text(".")
                    
                    Text("Information is sourced from website results")
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(Font.Typography.caption)
                .foregroundStyle(Color.Token.textSecondaryInverted)
                .padding(.top, 24)
                
                Spacer()
                
                HStack(alignment: .center) {
                    MacroNutrient(macroLabel: "Low Cal", macroValue: "100")
                    
                    MacroNutrient(macroLabel: "Protein", macroValue: "2g")
                    
                    MacroNutrient(macroLabel: "Carbs", macroValue: "12.75")
                    
                    MacroNutrient(macroLabel: "Fat", macroValue: "3.67g")
                }
                .font(Font.Typography.body)
                .foregroundStyle(Color.Token.textSecondaryInverted)
                .padding(.top, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    FinalTestView()
}
