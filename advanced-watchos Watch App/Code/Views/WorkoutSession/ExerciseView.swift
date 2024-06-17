//
//  ExerciseView2.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct ExerciseView: View {
    /// View Models
    @ObservedObject var exerciseVM: ExerciseViewModel
    
    // Below state variables are only used for HorizontalSlider to work as it takes Binding argument.
    @State private var weight: CGFloat = 0
    @State private var reps: CGFloat = 0
    
    var weightSliderViewConfig: HorizontalSliderView.Config = .init(
        label: "KG",
        roundingSpecifier: Rounding.hundredths.specifierString(),
        sliderConfig: .init(count: 300, steps: 4, spacing: 8, multiplier: 1)
    )
    var repsSliderViewConfig: HorizontalSliderView.Config = .init(
        label: "REPS",
        roundingSpecifier: Rounding.ones.specifierString(),
        sliderConfig: .init(count: 200, steps: 5, spacing: 10, multiplier: 5)
    )
    
    /// Toggles
    @State var showOptionsMenu: Bool = false
    @State var showWeightSlider: Bool = false
    @State var showRepsSlider: Bool = false
    @State var showSetRecorder: Bool = false
    
    let screenBounds = WKInterfaceDevice.current().screenBounds
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exerciseVM.exercise.name)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .lineLimit(screenBounds.width >= 180 ? 2 : 1)
            
                .pageHeaderTextStyle()
                        
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .lastTextBaseline) {
                    Text("\(exerciseVM.exercise.sets[exerciseVM.currentSet].weight, specifier: Rounding.hundredths.specifierString())")
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
                    Text("\(exerciseVM.exercise.sets[exerciseVM.currentSet].reps)")
                        .primaryEditableTextStyle(lineForegroundStyle: .gray)
                        .onTapGesture {
                            showRepsSlider.toggle()
                        }
                    Image(systemName: "repeat")
                        .foregroundStyle(.blue)
                        .labelImageStyle()
                    Spacer()
                }
                
                HStack(alignment: .lastTextBaseline) {
                    Text("\(exerciseVM.exercise.sets[exerciseVM.currentSet].type.description)")
                        .secondaryLabelStyle()
                        .bold()
                    Text("(Set \(exerciseVM.currentSet + 1) of \(exerciseVM.exercise.sets.count))")
                        .secondaryLabelStyle()
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.leading, 2)
            }
            
            HStack(alignment: .bottom) {
                Button(action: {
                    showOptionsMenu.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                })
                .tint(.gray)
                
                Button(action: {
                    if exerciseVM.setsVM[exerciseVM.currentSet].state == ExerciseSetState.notStarted {
                        exerciseVM.setsVM[exerciseVM.currentSet].state = ExerciseSetState.started
                        showSetRecorder = true
                    } else {
                        exerciseVM.completeCurrentSet(setPerformance: UserSetPerformance(
                                type: exerciseVM.exercise.sets[exerciseVM.currentSet].type,
                                status: .completed,
                                weight: exerciseVM.exercise.sets[exerciseVM.currentSet].weight,
                                reps: exerciseVM.exercise.sets[exerciseVM.currentSet].reps
                            )
                        )
                    }
                }, label: {
                    Image(systemName: exerciseVM.setsVM[exerciseVM.currentSet].state == ExerciseSetState.completed ? "arrow.right" : "play")
                })
                .tint(.green)
            }
            .secondaryTextStyle()
        }
        .onAppear {
            weight = CGFloat(exerciseVM.exercise.sets[exerciseVM.currentSet].weight)
            reps = CGFloat(exerciseVM.exercise.sets[exerciseVM.currentSet].reps)
        }
        
//        Options modal animation.
        .animation(.easeInOut(duration: 0.3), value: showOptionsMenu)
        .sheet(isPresented: $showOptionsMenu, content: {
            ExerciseOptionsView(showModal: $showOptionsMenu)
        })
        
//        Weight slider view animation.
        .animation(.easeInOut(duration: 0.3), value: showWeightSlider)
        .sheet(isPresented: $showWeightSlider, onDismiss: {
            exerciseVM.exercise.sets[exerciseVM.currentSet].weight = Float32(weight)
        }, content: {
            HorizontalSliderView(
                config: weightSliderViewConfig,
                value: $weight,
                viewToggle: $showWeightSlider,
                sliderValue: weight
            )
        })
        
//        Reps slider view animation.
        .animation(.easeInOut(duration: 0.3), value: showRepsSlider)
        .sheet(isPresented: $showRepsSlider, onDismiss: {
            exerciseVM.exercise.sets[exerciseVM.currentSet].reps = Int32(reps)
        }, content: {
            HorizontalSliderView(
                config: repsSliderViewConfig,
                value: $reps,
                viewToggle: $showRepsSlider,
                sliderValue: reps
            )
        })
        
//        Set recorder view animation.
        .animation(.easeInOut(duration: 0.3), value: showSetRecorder)
        .sheet(isPresented: $showSetRecorder, onDismiss: {
            showSetRecorder = false
        }, content: {
            SetRecordView(setVM: exerciseVM.setsVM[exerciseVM.currentSet])
        })
    }
}

#Preview {
    ExerciseView(exerciseVM: ExerciseViewModel(dummyExerciseData[0]))
        .frame(maxWidth: .infinity, alignment: .leading)
        .scenePadding([.horizontal, .top])
        .ignoresSafeArea(edges: .bottom)
        .background(.black)
}
