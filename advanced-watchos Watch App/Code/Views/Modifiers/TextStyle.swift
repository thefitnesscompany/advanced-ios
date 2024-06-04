//
//  EditableText.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

extension View {
    func primaryEditableTextStyle(lineForegroundStyle: Color) -> some View {
       self
           .background(
               Line()
                   .stroke(style: StrokeStyle(lineWidth: 2, dash: [2]))
                   .frame(height: 1)
                   .padding(.top, 36)
                   .padding(.leading, 2)
                   .foregroundStyle(lineForegroundStyle)
           )
           .secondaryTextStyle()
   }
    
    func primaryTextStyle() -> some View {
        self
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
    }
    
    func secondaryTextStyle() -> some View {
        self
            .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
    }
    
    func primaryLabelStyle() -> some View {
        self
            .font(.system(.caption, design: .rounded).monospacedDigit().lowercaseSmallCaps())
    }
    
    func secondaryLabelStyle() -> some View {
        self
            .font(.system(.caption, design: .rounded))
    }
    
    func pageHeaderTextStyle() -> some View {
        self
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(.headline))
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }
}
