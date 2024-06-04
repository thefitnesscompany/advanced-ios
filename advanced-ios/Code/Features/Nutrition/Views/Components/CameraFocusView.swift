//
//  CameraFocusView.swift
//  advanced-ios
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct CameraFocusView: View {
    @Binding var position: CGPoint
    
    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
            .foregroundColor(.clear)
            .border(Color.yellow, width: 1.5)
            .position(x: position.x, y: position.y)
    }
}

#Preview {
    CameraFocusViewPreview()
}

struct CameraFocusViewPreview: View {
    @State var position: CGPoint = CGPoint(x: 200, y: 300)
    
    var body: some View {
        CameraFocusView(position: $position)
    }
}
