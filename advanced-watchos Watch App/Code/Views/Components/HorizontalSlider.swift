//
//  HorizontalSlider.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

struct HorizontalSlider: View {
    /// Config
    var config: Config
    @Binding var value: CGFloat
    
    /// View Properties
    @State private var isLoaded: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let horizontalPadding = size.width / 2
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    let totalSteps = config.steps * config.count
                    
                    ForEach(0...totalSteps, id: \.self) { index in
                        let remainder = index % config.steps
                        
                        Divider()
                            .background(.gray)
                            .frame(width: 0, height: remainder == 0 ? 20 : 10, alignment: .center)
                            .frame(maxHeight: 20, alignment: .bottom)
                            .overlay(alignment: .bottom) {
                                if remainder == 0 && config.showsText {
                                    Text("\((index / config.steps) * config.multiplier)")
                                        .font(.caption)
                                        .textScale(.secondary)
                                        .fixedSize()
                                        .offset(y: 20)
                                }
                            }
                    }
                }
                .frame(height: size.height)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                return isLoaded ? Int(value * CGFloat(config.steps)) / config.multiplier : nil
            }, set: { newValue in
                if let newValue {
                    value = CGFloat(newValue) / CGFloat(config.steps) * CGFloat(config.multiplier)
                }
            }))
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .padding(.bottom, 20)
            })
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear {
                if !isLoaded {
                    isLoaded.toggle()
                }
            }
        }
    }
    
    struct Config: Equatable {
        var count: Int
        var steps: Int = 10
        var spacing: CGFloat = 5
        var multiplier: Int = 10
        var showsText: Bool = true
    }
}

#Preview {
    HorizontalSliderPreview()
}

struct HorizontalSliderPreview: View {
   private var config: HorizontalSlider.Config = .init(count: 300, steps: 4, spacing: 8, multiplier: 1)
    @State private var value: CGFloat = 100
    
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text(verbatim: "\(value)")
                    .font(.title)
                    .contentTransition(.numericText(value: value))
                    .animation(.snappy, value: value)
                
                Text("kgs")
                    .font(.title2)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
            }
            
            HorizontalSlider(config: config, value: $value)
                .frame(height: 60)
                .padding(.bottom)
        }
    }
}
