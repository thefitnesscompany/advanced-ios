//
//  WorkoutView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 04/06/24.
//

import SwiftUI

struct WorkoutView: View {
    /// View Models
    @ObservedObject var workoutVM: WorkoutViewModel
    
    @State var crownValue: Double = 0
    
    var body: some View {
        TabView(selection: $workoutVM.currentExerciseIdx) {
            ForEach($workoutVM.exercisesVM.indices, id: \.self) { index in
                ExerciseView(exerciseVM: workoutVM.exercisesVM[index])
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
    WorkoutView(workoutVM: WorkoutViewModel(plannedExercises: dummyExerciseData))
}
