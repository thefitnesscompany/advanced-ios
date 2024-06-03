//
//  MetricsView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 29/05/24.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: Date(),
                                             isPaused: false)) { context in
            VStack(alignment: .leading, spacing: 0) {
                ElapsedTimeView(elapsedTime: 0, showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                    .padding(.bottom, -8)
                
                HStack(alignment: .lastTextBaseline) {
                    let measurement = Measurement(value: 0, unit: UnitEnergy.kilocalories)
                        .formatted(.measurement(
                            width: .abbreviated,
                            usage: .workout,
                            numberFormatStyle: .number.precision(.fractionLength(0))
                        ))
                    
                    let parts = measurement.split(separator: " ")
                    let value = String(parts.first ?? "0")
                    
                    Text(value)
                    
                    VStack(alignment: .leading) {
                        Text("ACTIVE")
                            .foregroundColor(.white)
                            .font(.system(size: 15, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                            .bold()
                            .padding(.bottom, -6)
                        Text("KCAL")
                            .foregroundColor(.white)
                            .font(.system(size: 15, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                            .bold()
                    }
                    .frame(alignment: .leadingLastTextBaseline)
                    
                    Spacer()
                }
                .padding(.bottom, -10)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("\(0)")
                    
                    Image(systemName: "heart.fill")
                        .frame(alignment: .leadingLastTextBaseline)
                        .foregroundStyle(.red)
                        .labelImageStyle()
                    
                        .scaleEffect(animationAmount)
                        .animation(
                            .linear(duration: 0.1)
                                .delay(0.2)
                                .repeatForever(autoreverses: true),
                            value: animationAmount
                        )
                        .onAppear {
                            animationAmount = 1.1
                        }
                    
                    Spacer()
                }
                
//                    Text(Measurement(value: 0, unit: UnitLength.kilometers).formatted(.measurement(width: .abbreviated, usage: .road)))
                
                HStack(alignment: .bottom) {
                    Button(action: {}, label: {
                        Image(systemName: "xmark")
                    })
                    .tint(.red)
                    
                    Button(action: {}, label: {
                        Image(systemName: "play")
                    })
                    .tint(.yellow)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .scenePadding()
            
            .primaryTextStyle()
        }
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool

    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
