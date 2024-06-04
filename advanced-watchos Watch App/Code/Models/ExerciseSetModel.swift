//
//  ExerciseSetModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import Foundation

enum ExerciseSetType {
    case warmup
    case working
    case failure
    case drop
    
    var description: String {
        switch self {
        case .warmup: return "Warmup"
        case .working: return "Working"
        case .failure: return "Failure"
        case .drop: return "Drop"
        }
      }
}

struct ExerciseSet {
    let type: ExerciseSetType
    var weight: Float32
    var reps: Int32
}
