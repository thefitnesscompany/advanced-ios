//
//  RecordView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 30/05/24.
//

import SwiftUI

struct SetRecordViewLegacy: View {
    var body: some View {
        Color.green
            .opacity(10.0)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    Text("Set 1") // Detecting...
                        .font(.system(.headline, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                    VStack(alignment: .center, spacing: 8) {
                        HStack(alignment: .center) {
                            Button(action: {}, label: {
                                Image(systemName: "minus")
                            })
                            .frame(width: 50, height: 50)
                            
                            Spacer()
                        
                            ZStack(alignment: .center) {
                                Text("105.25")
                                    .font(.system(.title3, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                
                                Text("KG")
                                    .padding(.top, 35)
                                    .font(.system(size: 12, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                            }
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                            })
                            .frame(width: 50, height: 50)
                        }
                        .font(.system(.caption, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                        
                        HStack(alignment: .center) {
                            Button(action: {}, label: {
                                Image(systemName: "minus")
                            })
                            .frame(width: 50, height: 50)
                            
                            Spacer()
                            
                            ZStack(alignment: .center) {
                                Text("100")
                                    .font(.system(.title3, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                
                                Text("REPS")
                                    .padding(.top, 35)
                                    .font(.system(size: 12, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                            }
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                            })
                            .frame(width: 50, height: 50)
                        }
                        .font(.system(.caption, design: .rounded).monospacedDigit().lowercaseSmallCaps())
  
                    }
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "checkmark") // arrow.forward
                    })
                    .frame(maxWidth: .infinity)
                    .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                }
                .frame(maxWidth: .infinity)
                .scenePadding()
            )
    }
}

#Preview {
    SetRecordViewLegacy()
}
