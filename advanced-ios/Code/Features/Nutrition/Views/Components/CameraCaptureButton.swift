//
//  CameraCaptureButton.swift
//  advanced-ios
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct CameraCaptureButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center) // 70
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 69, height: 69, alignment: .center) // 59
                )
        }
    }
}

#Preview {
    Color.black
        .overlay {
            CameraCaptureButton {
            }
        }
}
