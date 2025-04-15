//
//  Dish.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//
import Foundation
import SwiftUI

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let mealType: MealType
    let executionTime: ExecutionTime
    let ingredients: [Ingredients]
    let description: String?
    let nutritionFacts: [String: String]?
    let preparationSteps: [PreparationStep]?
    
    var ingredientsCount: Int {
        ingredients.count
    }
    
    var executionTimeString: String {
        switch executionTime {
        case .fast:
            return "dish.execution.fast".localized(table: "Meals")
        case .medium:
            return "dish.execution.medium".localized(table: "Meals")
        case .slow:
            return "dish.execution.slow".localized(table: "Meals")
        }
    }
    
    var executionTimeColor: Color {
        switch executionTime {
        case .fast:
            return .green
        case .medium:
            return .orange
        case .slow:
            return .red
        }
    }
    
    init(name: String, mealType: MealType, executionTime: ExecutionTime, ingredients: [Ingredients], description: String? = nil, nutritionFacts: [String: String]? = nil, preparationSteps: [PreparationStep]? = nil) {
        self.name = name
        self.mealType = mealType
        self.executionTime = executionTime
        self.ingredients = ingredients
        self.description = description
        self.nutritionFacts = nutritionFacts
        self.preparationSteps = preparationSteps
    }
    
    struct Ingredients: Identifiable {
        let id = UUID()
        let name: String
        let quantity: Double
        let quantityType: QuantityType
    }
    
    struct PreparationStep: Identifiable {
        let id = UUID()
        let title: String
        let description: String
    }
    
    enum ExecutionTime {
        case fast
        case medium
        case slow
    }
    
    enum QuantityType: String {
        case grams = "g"
        case number = "pz"
    }
}

