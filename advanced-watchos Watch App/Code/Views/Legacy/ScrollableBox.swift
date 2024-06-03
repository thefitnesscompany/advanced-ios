//
//  ScrollableBox2.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 31/05/24.
//

import SwiftUI

enum LabelDirection {
    case leading
    case trailing
}

struct ScrollableBox<T: Equatable>: View {
    var label: String
    let labelDirection: LabelDirection
    @Binding var value: Float32
    @Binding var activeBox: T?
    let identifier: T
    let rounding: Rounding

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor((activeBox == identifier) ? Color.blue : Color.gray)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    let labelText = Text("\(label)")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                        .frame(alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if labelDirection == .leading {
                        labelText.frame(alignment: .leading)
                    }
                    
                    Text("\(value, specifier: rounding.specifierString())")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if labelDirection == .trailing {
                        labelText.frame(alignment: .trailing)
                    }
                }
                .font(.system(.title3, design: .rounded).monospacedDigit().lowercaseSmallCaps().bold())
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 12)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .onTapGesture {
            activeBox = identifier
        }
    }
}

#Preview {
    ScrollableBoxPreview()
}

struct ScrollableBoxPreview: View {
    enum ActiveBox {
        case weight
        case reps
    }
    
    @State private var activeBox: ActiveBox?

    var body: some View {
        HStack(spacing: 8) {
            ScrollableBox(
                label: "KG",
                labelDirection: .trailing,
                value: .constant(205),
                activeBox: $activeBox,
                identifier: .weight,
                rounding: Rounding.tenths
            )
            ScrollableBox(
                label: "X",
                labelDirection: .leading,
                value: .constant(10),
                activeBox: $activeBox,
                identifier: .reps,
                rounding: Rounding.ones
            )
        }
        .onAppear {
            activeBox = .weight
        }
    }
}
