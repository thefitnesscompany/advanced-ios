//
//  FoodCheckIn.swift
//  advanced-ios
//
//  Created by Harsh Patel on 14/06/24.
//

import Foundation
import SwiftData

@Model
final class FoodCheckIn {
    @Attribute(.unique) var id: String
    var createdAt: Date
    @Attribute(.externalStorage) var image: Data?
    var textDescription: String?
    @Relationship(deleteRule: .cascade) var detectedItems: [DetectedFoodItem]
    
    init(id: String = UUID().uuidString, createdAt: Date, image: Data? = nil, textDescription: String? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.image = image
        self.textDescription = textDescription
        self.detectedItems = []
    }
}

@Model
final class DetectedFoodItem {
    @Attribute(.unique) var id: String
    @Relationship(deleteRule: .cascade) var mainFoodItem: FoodItem
    @Relationship(deleteRule: .cascade) var couldBeFoodItems: [FoodItem]
    var quantity: Float
    var unit: String
    // Serving weight (in grams) of single unit of this food item.
    var unitServingWeight: Float
    
    init(id: String, mainFoodItem: FoodItem, couldBeFoodItemIds: [FoodItem] = [], quantity: Float, unit: String, unitServingWeight: Float) {
        self.id = id
        self.mainFoodItem = mainFoodItem
        self.couldBeFoodItems = couldBeFoodItemIds
        self.quantity = quantity
        self.unit = unit
        self.unitServingWeight = unitServingWeight
    }
}

@Model
final class FoodItem {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade) var nutritionPer100Gram: NutritionalInfo
    
    init(id: String, name: String, nutritionPer100Gram: NutritionalInfo) {
        self.id = id
        self.name = name
        self.nutritionPer100Gram = nutritionPer100Gram
    }
}

@Model
final class NutritionalInfo {
    // All values according to standard serving size of 100 grams.
    var carbs: Float
    var protein: Float
    var fat: Float
    
    @Transient
    var calories: Float {
        return 4 * (self.carbs + self.protein) + 9 * self.fat
    }
    
    init(carbs: Float, protein: Float, fat: Float) {
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
    }
}
