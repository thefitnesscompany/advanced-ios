//
//  PresenterView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 11/06/24.
//

import SwiftUI

struct PresenterView: View {
    enum ActiveView {
        case camera, daily, monthly
    }
    
    @ObservedObject var cameraViewModel = CameraViewModel()
    @State private var activeView: ActiveView = .camera
    
    var body: some View {
        AppContainer {
            switch activeView {
            case .camera:
                CameraView(viewModel: cameraViewModel, activeView: $activeView)
                    .transition(.push(from: .bottom))
            case .daily:
                DayWiseView(activeView: $activeView, images: cameraViewModel.thumbnails)
                    .transition(.move(edge: .bottom).combined(with: .move(edge: .leading)))
            case .monthly:
                MonthWiseView(activeView: $activeView, images: cameraViewModel.thumbnails)
            }
        }
    }
}

#Preview {
    PresenterView()
}
