//
//  HorizontalSliderView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

struct HorizontalSliderView: View {
    /// Config
    var config: Config
    @Binding var value: CGFloat
    @Binding var viewToggle: Bool
    
    /// View Properties
    @State var sliderValue: CGFloat // View specific value to allow persistence only when checkmark is clicked.
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack(alignment: .lastTextBaseline, spacing: 5) {
                    Text("\(sliderValue, specifier: config.roundingSpecifier)")
                        .font(.title)
                        .contentTransition(.numericText(value: sliderValue))
                        .animation(.snappy, value: sliderValue)
                        .padding(.bottom, 4)
                    
                    Text("\(config.label)")
                        .font(.title2)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                }
                
                HorizontalSlider(config: config.sliderConfig, value: $sliderValue)
                    .frame(height: 60)
                    .padding(.bottom)
            }
            
            Spacer()
            
            Button(action: {
                value = sliderValue
                viewToggle.toggle()
            }, label: {
                Image(systemName: "checkmark")
            })
            .secondaryTextStyle()
        }
    }
    
    struct Config {
        var label: String
        var roundingSpecifier: String = Rounding.ones.specifierString()
        var sliderConfig: HorizontalSlider.Config
    }
}

#Preview {
    HorizontalSliderViewPreview()
}

struct HorizontalSliderViewPreview: View {
//    private var config: HorizontalSliderView.Config = .init(label: "reps", sliderConfig: .init(count: 200, steps: 5, spacing: 10, multiplier: 5))
    
    private var config: HorizontalSliderView.Config = .init(
        label: "KG",
        roundingSpecifier: Rounding.hundredths.specifierString(),
        sliderConfig: .init(count: 300, steps: 4, spacing: 8, multiplier: 1)
    )
    
    @State private var value: CGFloat = 60.25

    @State private var showView: Bool = true
    
    var body: some View {
        HorizontalSliderView(config: config, value: $value, viewToggle: $showView, sliderValue: value)
    }
}
