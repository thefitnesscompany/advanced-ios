//
//  ExerciseTrackerModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import Foundation

enum ExerciseIntensity {
    case easy, medium, hard, failure
}

struct UserExercisePerformance {
    let exerciseId: String
    var timestamp: String?
    var sets: [UserSetPerformance]
    var intensity: ExerciseIntensity?
}
