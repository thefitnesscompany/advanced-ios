//
//  CameraView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 03/06/24.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel
    @Binding var activeView: PresenterView.ActiveView
    
    @State private var isFocused = false
    @State private var isScaled = false
    @State private var focusLocation: CGPoint = .zero
    @State private var currentZoomFactor: CGFloat = 1.0
        
    var body: some View {
        AppContainer(bgColor: Color.black) {
            VStack(spacing: 0) {
                Button(action: {
                    viewModel.switchFlash()
                }, label: {
                    Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                        .font(.system(.title3, weight: .medium))
                })
                .accentColor(viewModel.isFlashOn ? .yellow : .white)
                .padding(.bottom, 20)
                
                ZStack {
                    CameraPreview(session: viewModel.session) { tapPoint in
                        isFocused = true
                        focusLocation = tapPoint
                        viewModel.setFocus(point: tapPoint)
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            self.currentZoomFactor += value - 1.0
                            self.currentZoomFactor = min(max(self.currentZoomFactor, 0.5), 10)
                            self.viewModel.zoom(with: currentZoomFactor)
                        })
//                        .animation(.easeInOut, value: 0.5)
                                            
                    if isFocused {
                        CameraFocusView(position: $focusLocation)
                            .scaleEffect(isScaled ? 0.8 : 1)
                            .onAppear {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                    self.isScaled = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        self.isFocused = false
                                        self.isScaled = false
                                    }
                                }
                            }
                    }
                }
                
                ZStack {
                    CameraCaptureButton { viewModel.captureImage() }
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        StackedThumbnails(photos: $viewModel.thumbnails)
                            .padding(.leading, 20)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    activeView = .daily
                                }
                            }
                        
                        Spacer()
//                            CameraSwitchButton { viewModel.switchCamera() }
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 40)
            }
        }
        .alert(isPresented: $viewModel.showAlertError) {
            Alert(
                title: Text(viewModel.alertError.title),
                message: Text(viewModel.alertError.message),
                dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle), action: {
                viewModel.alertError.primaryAction?()
            }))
        }
        .alert(isPresented: $viewModel.showSettingAlert) {
            Alert(
                title: Text("Warning"),
                message: Text("Application doesn't have all permissions to use camera and microphone, please change privacy settings."),
                dismissButton: .default(Text("Go to settings"), action: {
                self.openSettings()
            }))
        }
        .onAppear {
            viewModel.setupBindings()
            viewModel.requestCameraPermission()
            viewModel.restorePhotos()
        }
    }
    
    func openSettings() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

struct CameraSwitchButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        }
    }
}

#Preview {
    CameraViewPreview()
}

struct CameraViewPreview: View {
    @ObservedObject var viewModel = CameraViewModel()
    @State var activeView: PresenterView.ActiveView = .camera
    
    var body: some View {
        CameraView(viewModel: viewModel, activeView: $activeView)
    }
}
