//
//  OptionsView.swift
//  advanced-watchos Watch App
//
//  Created by Harsh Patel on 31/05/24.
//

import SwiftUI

struct ExerciseOptionsView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Button(action: {
                    showModal.toggle()
                }, label: {
                    Image(systemName: "plus")
                    Text("Set")
                })
                
                Button(action: {
                    showModal.toggle()
                }, label: {
                    Image(systemName: "forward")
                    Text("Set")
                })
                
                Button(action: {
                    showModal.toggle()
                }, label: {
                    Image(systemName: "plus")
                    Text("Exercise")
                })
            }
        }
    }
}

#Preview {
    OptionsViewPreview()
}

struct OptionsViewPreview: View {
    @State var showModal: Bool = true
    
    var body: some View {
        ExerciseOptionsView(showModal: $showModal)
    }
}
