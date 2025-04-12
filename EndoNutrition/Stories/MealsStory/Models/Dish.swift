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
    
    var ingredientsCount: Int {
        ingredients.count
    }
    
    var executionTimeString: String {
        switch executionTime {
        case .fast:
            return "veloce"
        case .medium:
            return "medio"
        case .elaborate:
            return "elaborato"
        }
    }
    
    var executionTimeColor: Color {
        switch executionTime {
        case .fast:
            return .green
        case .medium:
            return .orange
        case .elaborate:
            return .red
        }
    }
    
    
    struct Ingredients: Identifiable {
        let id = UUID()
        let name: String
        let quantity: Double
        let quantityType: QuantityType
    }
    
    enum ExecutionTime {
        case fast
        case medium
        case elaborate
    }
    
    enum QuantityType {
        case grams
        case number
    }

}

