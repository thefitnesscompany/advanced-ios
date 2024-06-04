//
//  SetViewModel.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 04/06/24.
//

import Foundation
import SwiftUI

class SetViewModel: ObservableObject {
    @Published var state: ExerciseSetState {
        didSet {
            if state == .started {
                startPrediction()
            }
        }
    }
    
    init(setState: ExerciseSetState) {
        self.state = setState
    }
    
    func startPrediction() {
    }
    
    func stopPrediction() {
        // calculate final results
        // if final results matches the user input -> skip showing predictions screen
        // else, show predictions
        
        self.state = .completed
    }
}
