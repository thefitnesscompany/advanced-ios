//
//  SetRecordView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

struct SetRecordView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var setVM: SetViewModel
    
    var body: some View {
        Color.green
            .opacity(10.0)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading, spacing: 0) {
                    if setVM.state == .started {
                        Text("Recording...")
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .pageHeaderTextStyle()
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .lastTextBaseline) {
                                Text("156.25")
                                    .secondaryTextStyle()
                                Text("KG")
                                    .primaryLabelStyle()
                                    .bold()
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text("105")
                                    .secondaryTextStyle()
                                Image(systemName: "repeat")
                                    .labelImageStyle()
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            setVM.stopPrediction()
                        }, label: {
                            Image(systemName: "pause")
                        })
                        .secondaryTextStyle()
                    } else if setVM.state == .completed {
                        Text("We calculated ")
                        + Text(verbatim: "\(100) reps").bold().font(.system(.callout, design: .rounded))
                                    + Text(" of ")
                        + Text(verbatim: "\(100.25) kgs").bold().font(.system(.callout, design: .rounded))
                                    + Text(" for this ")
                        + Text("warmup").bold().font(.system(.callout, design: .rounded))
                                    + Text(" set.")
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Text("Naah")
                            })
                            
                            Button(action: {
                                dismiss()
                            }, label: {
                                Text("Yaay")
                            })
                        }
                        .font(.system(.caption, design: .rounded))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .scenePadding([.horizontal, .top])
            )
    }
}

#Preview {
    SetRecordViewPreview()
}

struct SetRecordViewPreview: View {
    @State var setState: ExerciseSetState = .started
    
    var body: some View {
        SetRecordView(setVM: SetViewModel(setState: setState))
    }
}
