//
//  SessionPagingView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 29/05/24.
//

import SwiftUI
import WatchKit

struct SessionPagingView: View {
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: Tab = .metrics

    enum Tab {
        // controls
        case metrics, workout, nowPlaying
    }

    var body: some View {
//        NavigationStack {
            TabView(selection: $selection) {
    //            ControlsView().tag(Tab.controls)
                MetricsView().tag(Tab.metrics)
                WorkoutView(workoutVM: WorkoutViewModel(plannedExercises: dummyExerciseData)).tag(Tab.workout)
                NowPlayingView().tag(Tab.nowPlaying)
            }
//            .navigationTitle("")
//            .navigationBarHidden(selection == .nowPlaying)
            .navigationBarBackButtonHidden(true)
            .onChange(of: false, {
                displayMetricsView()
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
            .onChange(of: isLuminanceReduced, {
                displayMetricsView()
            })
//        }
        
    }

    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
