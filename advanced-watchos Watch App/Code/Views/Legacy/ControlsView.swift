//
//  ControlsView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 29/05/24.
//

import SwiftUI

struct ControlsView: View {
//    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        HStack {
            VStack {
                Button {
//                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
//                    workoutManager.togglePause()
                } label: {
//                    Image(systemName: workoutManager.running ? "pause" : "play")
                    Image(systemName: "play")
                }
                .tint(.yellow)
                .font(.title2)
                Text("Resume")
//                Text(workoutManager.running ? "Pause" : "Resume")
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
//        ControlsView().environmentObject(WorkoutManager())
    }
}
