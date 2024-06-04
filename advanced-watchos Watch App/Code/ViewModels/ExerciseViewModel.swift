//
//  ExercisesViewModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var currentSet: Int
    @Published var exercise: Exercise
    @Published var setsVM: [SetViewModel]

    var performance: UserExercisePerformance
    
    init(_ exercise: Exercise) {
        self.currentSet = 0

        self.exercise = exercise
        self.performance = ExerciseViewModel.getZeroStateExercisesPerformance(exercise: exercise)
        
        // TODO: Handle cases of set updation from options menu.
        self.setsVM = exercise.sets.map({ _ in
            SetViewModel(setState: .notStarted)
        })
    }
    
    func completeCurrentSet(setPerformance: UserSetPerformance) {
        performance.sets[currentSet] = setPerformance
        
        currentSet += 1
    }
}

// MARK: Zero State Docs
extension ExerciseViewModel {
    private static func getZeroStateExercisesPerformance(exercises: [Exercise]) -> [UserExercisePerformance] {
        return exercises.map { exercise in
            return getZeroStateExercisesPerformance(exercise: exercise)
        }
    }
    
    private static func getZeroStateExercisesPerformance(exercise: Exercise) -> UserExercisePerformance {
        return UserExercisePerformance(
            exerciseId: exercise.id, timestamp: nil, sets: getZeroStateExerciseSetsPerformance(exercise: exercise), intensity: nil
        )
    }
    
    private static func getZeroStateExerciseSetsPerformance(exercise: Exercise) -> [UserSetPerformance] {
        return exercise.sets.map { set in
            return UserSetPerformance(
                type: set.type, status: .incomplete, startedAt: nil, stoppedAt: nil, weight: nil, reps: nil
            )
        }
    }
}
