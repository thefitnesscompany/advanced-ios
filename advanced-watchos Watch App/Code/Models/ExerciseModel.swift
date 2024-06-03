//
//  Exercise.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 31/05/24.
//

import Foundation

struct Exercise {
    let id: String
    let name: String
    var sets: [ExerciseSet]
}

let dummyExerciseData: [Exercise] = [
    Exercise(
        id: "scr",
        name: "Standing Calf Raises",
        sets: [
            ExerciseSet(type: .warmup, weight: 60.25, reps: 10),
            ExerciseSet(type: .working, weight: 75.5, reps: 10),
            ExerciseSet(type: .working, weight: 80.5, reps: 8),
            ExerciseSet(type: .failure, weight: 82.75, reps: 8)
        ]
    ),
    Exercise(
        id: "bs",
        name: "Back Squats",
        sets: [
            ExerciseSet(type: .warmup, weight: 50.0, reps: 10),
            ExerciseSet(type: .working, weight: 100.0, reps: 10),
            ExerciseSet(type: .working, weight: 127.75, reps: 10),
            ExerciseSet(type: .failure, weight: 135.0, reps: 8),
            ExerciseSet(type: .failure, weight: 135.25, reps: 8)
        ]
    ),
    Exercise(
        id: "le",
        name: "Leg Extensions",
        sets: [
            ExerciseSet(type: .working, weight: 60.0, reps: 10),
            ExerciseSet(type: .failure, weight: 70.75, reps: 10),
            ExerciseSet(type: .failure, weight: 80.5, reps: 8),
            ExerciseSet(type: .failure, weight: 85.25, reps: 8)
        ]
    )
]
