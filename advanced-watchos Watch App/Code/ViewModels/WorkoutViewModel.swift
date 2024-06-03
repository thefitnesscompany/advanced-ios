//
//  WorkoutViewModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var exercises: [Exercise]
    @Published var currentExerciseIdx: Int {
        didSet {
            self.currentExerciseVM = self.exercisesVM[currentExerciseIdx]
        }
    }
    @Published var currentExerciseVM: ExerciseViewModel
    
    var exercisesVM: [ExerciseViewModel]
    
    init(plannedExercises: [Exercise]) {
        let exercisesVM = plannedExercises.map({ exercise in
            return ExerciseViewModel(exercise)
        })
        
        self.exercises = plannedExercises
        self.currentExerciseIdx = 0
        self.exercisesVM = exercisesVM
        self.currentExerciseVM = exercisesVM[0]
    }
    
    func addNextExercise(exercise: Exercise) {
        if exercises.indices.contains(currentExerciseIdx) {
            let newPos = currentExerciseIdx + 1
            
            exercises.insert(exercise, at: newPos)
            exercisesVM.insert(ExerciseViewModel(exercise), at: newPos)
            currentExerciseIdx = newPos
        }
    }
    
    func deleteCurrentExercise() {
        if exercises.indices.contains(currentExerciseIdx) {
            exercises.remove(at: currentExerciseIdx)
            exercisesVM.remove(at: currentExerciseIdx)

            if currentExerciseIdx >= exercises.count {
                currentExerciseIdx = max(0, exercises.count - 1)
            }
        }
    }
    
    func completeCurrentExercise() {
        // TODO: Record intensity as well.
        currentExerciseVM.performance.timestamp = Date().ISO8601Format()
        
        currentExerciseIdx += 1
    }
}
