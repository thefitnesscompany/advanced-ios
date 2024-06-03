//
//  UserSetPerformanceModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import Foundation

enum UserSetPerformanceStatus {
    case incomplete, skipped, completed
}

struct UserSetPerformance {
    let type: ExerciseSetType
    var status: UserSetPerformanceStatus
    var startedAt: String?
    var stoppedAt: String?
    var weight: Float32?
    var reps: Int32?
}
