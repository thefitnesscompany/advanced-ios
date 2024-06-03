//
//  ImageStyle.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

extension View {
    func labelImageStyle() -> some View {
        self
            .imageScale(.small)
            .frame(width: 20)
            .padding(.leading, 4)
            .secondaryTextStyle()
    }
}
