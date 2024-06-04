//
//  ExerciseView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 01/06/24.
//

import SwiftUI

struct ExerciseViewLegacy: View {
    
    enum ScrollableFields: Hashable {
      case weight
      case reps
    }
    
    @State private var exerciseIdx: Int = 0
    @State private var exercises: [Exercise] = dummyExerciseData
    
    // To manage animation offset
    @State private var offset: CGFloat = 0.0
    @State private var animate: Bool = false
    
    @State private var activeBox: ScrollableFields?
    @State private var weight: Float32 = 0
    @State private var reps: Float32 = 0
    
    // To manage options modal
    @State var showOptions: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercises[exerciseIdx].name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(.headline))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding([.top])
            
                // Animation
                .offset(y: offset)
                .animation(.easeInOut, value: offset)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    HStack(alignment: .lastTextBaseline) {
                        ZStack {
                            Text("105.25")
                                .layoutPriority(2)
                            
//                                Line()
//                                   .stroke(style: StrokeStyle(lineWidth: 2, dash: [2]))
//                                   .frame(height: 1)
//                                   .padding(.top, 35)
//                                   .padding(.leading, 8)
//                                   .foregroundStyle(.gray)
                        }
                        
                        Text("KG")
                            .font(.system(.footnote))
                    }
                    .layoutPriority(2)
                        
                    Spacer()
                    
                    HStack(alignment: .lastTextBaseline) {
                        Text("X")
                            .font(.system(.footnote, design: .rounded))
                        
                        Text("99")
                            .layoutPriority(2)
                    }
                    .layoutPriority(1)
                    
                }
                .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text("Till Failure")
                        .font(.system(.caption))
                        .foregroundStyle(.orange)
                    
                    Text("(1 of 5)")
                        .font(.system(.caption))
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom])
            
            HStack(alignment: .bottom) {
                Button(action: {
                    showOptions.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                })
                .tint(.gray)
                
                Button(action: {}, label: {
                    Image(systemName: "play")
                })
                .tint(.green)
            }
            .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .padding([.top])
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
        
        .onAppear {
            self.activeBox = .weight
        }
        .onTapGesture {
            self.activeBox = nil
        }
        
//        Scroll through exercises
        .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
            .onEnded({ value in
                handleExerciseOrder(value)
            }))
        
//        Options modal animation
        .animation(.easeInOut(duration: 0.3), value: showOptions)
        .sheet(isPresented: $showOptions, content: {
            ExerciseOptionsView(showModal: $showOptions)
        })
    }
    
    private func handleExerciseOrder(_ value: DragGesture.Value) {
        if value.translation.height < 0 {
            // Next Exercise
            if exerciseIdx < exercises.count - 1 {
                withAnimation {
                    self.offset = 30
                }
                exerciseIdx += 1
            }
        } else if value.translation.height > 0 {
            // Previous Exercise
            if exerciseIdx > 0 {
                withAnimation {
                    self.offset = -30
                }
                exerciseIdx -= 1
            }
        }
        
        withAnimation {
            offset = 0
        }
    }
}

#Preview {
    ExerciseViewLegacy()
}

// VStack(alignment: .leading) {
//    HStack(spacing: 8) {
//        ScrollableBox(
//            label: "KG",
//            labelDirection: .trailing,
//            value: $weight,
//            activeBox: $activeBox,
//            identifier: .weight,
//            rounding: Rounding.tenths
//        )
//        .focusable(true)
//        .onTapGesture {
//            activeBox = .weight
//        }
//        .digitalCrownRotation(
//            Binding(get: {
//                activeBox == ScrollableFields.weight ? weight : 0
//            }, set: { value in
//                if activeBox == ScrollableFields.weight {
//                    weight = value
//                }
//            }),
//            from: 0,
//            through: 300,
//            by: 0.5,
//            sensitivity: .low,
//            isContinuous: true,
//            isHapticFeedbackEnabled: true
//        )
//        .onAppear {
//            weight = 10
//        }
//        
//        ScrollableBox(
//            label: "X",
//            labelDirection: .leading,
//            value: $reps,
//            activeBox: $activeBox,
//            identifier: .reps,
//            rounding: Rounding.ones
//        )
//        .focusable(true)
//        .onTapGesture {
//            activeBox = .reps
//        }
//        .digitalCrownRotation(
//            Binding(get: {
//                activeBox == ScrollableFields.reps ? reps : 0
//            }, set: { value in
//                if activeBox == ScrollableFields.reps {
//                    reps = value
//                }
//            }),
//            from: 1,
//            through: 100,
//            by: 1,
//            sensitivity: .low,
//            isContinuous: true,
//            isHapticFeedbackEnabled: true
//        )
//        .onAppear {
//            reps = 10
//        }
//    }
//    .padding([.top, .bottom])
//    
//    VStack(alignment: .center) {
//        Text(exercises[exerciseIdx].name.uppercased())
//            .frame(maxWidth: .infinity, alignment: .center)
//            .font(.system(.caption))
//            .fixedSize(horizontal: false, vertical: true)
//            .multilineTextAlignment(.leading)
//            .offset(y: offset)
//            .animation(.easeInOut, value: offset)
//        
//        Text("Warmup Set 1")
//            .font(.system(.caption))
//            .frame(maxWidth: .infinity, alignment: .center)
//            .foregroundColor(.gray)
//    }
//    
//    HStack(alignment: .bottom) {
//        Button(action: {
//            showOptions.toggle()
//        }, label: {
//            Image(systemName: "ellipsis")
//        })
//        .tint(.gray)
//        .frame(maxWidth: .infinity, alignment: .bottom)
//        
//        Button(action: {}, label: {
//            Image(systemName: "play")
//        })
//        .tint(.green)
//        .frame(maxWidth: .infinity)
//    }
//    .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
//    .padding([.top, .bottom])
// }
// .frame(maxWidth: .infinity)
// .onAppear {
//    self.activeBox = .weight
// }
// .onTapGesture {
//    self.activeBox = nil
// }
//
////        Scroll through exercises
// .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
//    .onEnded({ value in
//        handleExerciseOrder(value)
//    }))
//
////        Options modal animation
// .animation(.easeInOut(duration: 0.3), value: showOptions)
// .sheet(isPresented: $showOptions, content: {
//    OptionsView(showModal: $showOptions)
// })
//
// .scenePadding(.top)
// .navigationTitle(exercises[exerciseIdx].name)
// }
