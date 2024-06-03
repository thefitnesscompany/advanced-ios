//
//  SetRecordView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 02/06/24.
//

import SwiftUI

struct SetRecordView: View {
    @State var isRecording: Bool = true
    
    var body: some View {
        Color.green
            .opacity(10.0)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading, spacing: 0) {
                    if isRecording {
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
                        
                        Button(action: {}, label: {
                            Image(systemName: "pause")
                        })
                        .secondaryTextStyle()
                    } else {
                        Text("We think you did ")
                        + Text("\(10)").bold().font(.system(.callout, design: .rounded))
                                    + Text(" reps of ")
                        + Text("\(100) kgs").bold().font(.system(.callout, design: .rounded))
                                    + Text(" for this ")
                        + Text("warmup").bold().font(.system(.callout, design: .rounded))
                                    + Text(" set.")
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {}, label: {
                                Text("Naah")
                            })
                            
                            Button(action: {}, label: {
                                Text("Yaay")
                            })
                        }
                        .font(.system(.footnote, design: .rounded))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .scenePadding([.horizontal, .top])
            )
    }
}

#Preview {
    SetRecordView()
}
