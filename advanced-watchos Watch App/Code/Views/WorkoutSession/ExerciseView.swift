//
//  ExerciseView2.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

enum ScrollableFields: Hashable {
  case weight
  case reps
}

struct ExerciseView: View {
    /// View Models
    @ObservedObject var workoutVM: WorkoutViewModel
    
    /// View Properties
    @State private var weight: CGFloat = 0
    var weightSliderViewConfig: HorizontalSliderView.Config = .init(
        label: "KG",
        roundingSpecifier: Rounding.hundredths.specifierString(),
        sliderConfig: .init(count: 300, steps: 4, spacing: 8, multiplier: 1)
    )
    
    @State private var reps: CGFloat = 0
    var repsSliderViewConfig: HorizontalSliderView.Config = .init(
        label: "REPS",
        roundingSpecifier: Rounding.ones.specifierString(),
        sliderConfig: .init(count: 200, steps: 5, spacing: 10, multiplier: 5)
    )
    
    @State var crownValue: Double = 0
    
    /// Toggles
    @State var showOptions: Bool = false
    @State var showWeightSlider: Bool = false
    @State var showRepsSlider: Bool = false
    
    let screenBounds = WKInterfaceDevice.current().screenBounds
    
    var body: some View {
        TabView(selection: $workoutVM.currentExerciseIdx) {
            ForEach($workoutVM.exercises.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    let currentSet = workoutVM.currentExerciseVM.currentSet
                    let currentSetModel = workoutVM.exercises[index].sets[currentSet]
                    
                    // Show title for large screens only
                    if screenBounds.width >= 180 {
                        Text(workoutVM.exercises[index].name)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.top)
                        
                            .pageHeaderTextStyle()
                    }
                                
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(currentSet + 1) / \(workoutVM.exercises[index].sets.count)")
                                .secondaryTextStyle()
                            Text("\(currentSetModel.type.description)")
                                .secondaryLabelStyle()
                                .bold()
                            Spacer()
                        }
                        .padding(.bottom, -6)
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(weight, specifier: Rounding.hundredths.specifierString())")
                                .primaryEditableTextStyle(lineForegroundStyle: .gray)
                                .onTapGesture {
                                    showWeightSlider.toggle()
                                }
                            Text("KG")
                                .primaryLabelStyle()
                                .bold()
                            Spacer()
                        }
                        .padding(.bottom, -4)
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(reps, specifier: Rounding.ones.specifierString())")
                                .primaryEditableTextStyle(lineForegroundStyle: .gray)
                                .onTapGesture {
                                    showRepsSlider.toggle()
                                }
                            Image(systemName: "repeat")
                                .foregroundStyle(.blue)
                                .labelImageStyle()
                            Spacer()
                        }
                    }
                    
                    HStack(alignment: .bottom) {
                        Button(action: {
                            showOptions.toggle()
                        }, label: {
                            Image(systemName: "ellipsis")
                        })
                        .tint(.gray)
                        
                        Button(action: {
                        }, label: {
                            Image(systemName: "play")
                        })
                        .tint(.green)
                    }
                    .secondaryTextStyle()
                }
            }
        }
        .tabViewStyle(VerticalPageTabViewStyle())
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .scenePadding([.horizontal, .top])
        .ignoresSafeArea(edges: .bottom)
        .background(.black)
        
        .digitalCrownRotation(
            detent: $crownValue,
            from: 1,
            through: 100,
            by: 1,
            sensitivity: .low,
            isContinuous: true,
            isHapticFeedbackEnabled: true,
            onChange: { crownEvent in
                workoutVM.currentExerciseIdx = roundDigitalCrownValue(value: crownEvent.offset, velocity: crownEvent.velocity)
            }
        )
        
        .onAppear {
            let currentSet = workoutVM.currentExerciseVM.currentSet
            let currentSetModel = workoutVM.exercises[workoutVM.currentExerciseIdx].sets[currentSet]
            
            weight = CGFloat(currentSetModel.weight)
            reps = CGFloat(currentSetModel.reps)
        }
        
//        Options modal animation
        .animation(.easeInOut(duration: 0.3), value: showOptions)
        .sheet(isPresented: $showOptions, content: {
            ExerciseOptionsView(showModal: $showOptions)
        })
        
//        Weight slider view animation
        .animation(.easeInOut(duration: 0.3), value: showWeightSlider)
        .sheet(isPresented: $showWeightSlider, content: {
            HorizontalSliderView(
                config: weightSliderViewConfig,
                value: $weight,
                viewToggle: $showWeightSlider,
                sliderValue: weight
            )
        })
        
//        Reps slider view animation
        .animation(.easeInOut(duration: 0.3), value: showRepsSlider)
        .sheet(isPresented: $showRepsSlider, content: {
            HorizontalSliderView(
                config: repsSliderViewConfig,
                value: $reps,
                viewToggle: $showRepsSlider,
                sliderValue: reps
            )
        })
    }
    
    private func roundDigitalCrownValue(value: Double, velocity: CDouble) -> Int {
       let roundingRule: FloatingPointRoundingRule
       switch velocity {
       case let value where value < 0:
           roundingRule = .up
       case let value where value == 0:
           roundingRule = .toNearestOrAwayFromZero
       case let value where value > 0:
           roundingRule = .down
       default:
           roundingRule = .toNearestOrAwayFromZero
       }

       return Int(value.rounded(roundingRule))
    }
}

#Preview {
    ExerciseView(workoutVM: WorkoutViewModel(plannedExercises: dummyExerciseData))
}
