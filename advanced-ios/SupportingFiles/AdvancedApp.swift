//
//  advanced_iosApp.swift
//  advanced-ios
//
//  Created by Harsh Patel on 29/05/24.
//

import SwiftUI
import SwiftData

@main
struct AdvancedApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var modelContainer: ModelContainer = {
        let schema = Schema([
            FoodCheckIn.self,
            DetectedFoodItem.self,
            FoodItem.self,
            NutritionalInfo.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, allowsSave: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            PresenterView()
        }
        .modelContainer(modelContainer)
    }
}
