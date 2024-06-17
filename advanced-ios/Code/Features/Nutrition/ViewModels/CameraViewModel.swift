//
//  CameraViewModel.swift
//  advanced-ios
//
//  Created by Harsh Patel on 03/06/24.
//

import SwiftUI
import Combine
import Photos
import AVFoundation

class CameraViewModel: ObservableObject {
    @ObservedObject var cameraManager = CameraManager()
    
    @Published var isFlashOn = false
    @Published var showAlertError = false
    @Published var showSettingAlert = false
    @Published var isPermissionGranted: Bool = false
    
    private var maxThumbnailsCount = 3
    @Published var capturedImage: UIImage? {
        didSet {
            if capturedImage != nil {
                savePhoto(capturedImage!)
                
                DispatchQueue.main.async {
                    self.thumbnails.insert(self.capturedImage!, at: 0)
                    if self.thumbnails.count > self.maxThumbnailsCount {
                        self.thumbnails.removeLast(self.thumbnails.count - self.maxThumbnailsCount)
                   }
               }
            }
        }
    }
    @Published var thumbnails: [UIImage] = []
    
    var alertError: AlertError!
    var session: AVCaptureSession = .init()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        session = cameraManager.session
    }
    
    deinit {
        cameraManager.stopCapturing()
    }
    
    func setupBindings() {
        cameraManager.$shouldShowAlertView.sink { [weak self] value in
            self?.alertError = self?.cameraManager.alertError
            self?.showAlertError = value
        }
        .store(in: &cancelables)
        
        cameraManager.$capturedImage.sink { [weak self] image in
            self?.capturedImage = image
        }.store(in: &cancelables)
    }
    
    func savePhoto(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
               if let documentsDirectory = paths {
                   let fileName = Date().ISO8601Format() + ".jpg"
                   let fileURL = documentsDirectory.appendingPathComponent(fileName, isDirectory: false)
                   try? imageData.write(to: fileURL)
                   
                   // Store the file name in UserDefaults for quick access.
                   var savedPhotos = UserDefaults.standard.stringArray(forKey: "savedPhotos") ?? []
                   savedPhotos.insert(fileName, at: 0)
                   if savedPhotos.count > maxThumbnailsCount {
                       savedPhotos.removeLast(savedPhotos.count - maxThumbnailsCount)
                   }
                   
                   UserDefaults.standard.set(savedPhotos, forKey: "savedPhotos")
               }
        }
    }
    
    func restorePhotos() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        guard let documentsDirectory = paths.first else { return }
        var savedPhotos = UserDefaults.standard.stringArray(forKey: "savedPhotos") ?? []
        
        if savedPhotos.count > maxThumbnailsCount {
            savedPhotos = Array(savedPhotos.suffix(maxThumbnailsCount))
            UserDefaults.standard.set(savedPhotos, forKey: "savedPhotos")
        }

        var restoredImages: [UIImage] = []
        for fileName in savedPhotos {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
                restoredImages.append(image)
            }
        }
        
        DispatchQueue.main.async {
            self.thumbnails = restoredImages
        }
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isGranted in
            guard let self else { return }
            if isGranted {
                self.configureCamera()
                DispatchQueue.main.async {
                    self.isPermissionGranted = true
                }
            }
        }
    }
    
    func configureCamera() {
        checkForDevicePermission()
        cameraManager.configureCaptureSession()
    }
    
    func checkForDevicePermission() {
        let videoStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        DispatchQueue.main.async { [weak self] in
            if videoStatus == .authorized {
                self?.isPermissionGranted = true
            } else if videoStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
            } else if videoStatus == .denied {
                self?.isPermissionGranted = false
                self?.showSettingAlert = true
            }
        }
    }
    
    func switchCamera() {
        cameraManager.position = cameraManager.position == .back ? .front : .back
        cameraManager.switchCamera()
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        cameraManager.toggleTorch(tourchIsOn: isFlashOn)
    }
    
    func zoom(with factor: CGFloat) {
        cameraManager.setZoomScale(factor: factor)
    }
    
    func setFocus(point: CGPoint) {
        cameraManager.setFocusOnTap(devicePoint: point)
    }
    
    func captureImage() {
        requestGalleryPermission()
        let permission = checkGalleryPermissionStatus()
        if permission.rawValue != 2 {
            cameraManager.captureImage()
        }
    }
    
    func requestGalleryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                break
            case .denied:
                self.showSettingAlert = true
            default:
                break
            }
        }
    }
    
    func checkGalleryPermissionStatus() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
}
