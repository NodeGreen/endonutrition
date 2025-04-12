//
//  Meal.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI
import Foundation

struct Meal: Identifiable, Equatable {
    let id: Int
    let mealType: MealType
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }
    
    var title: String {
        switch mealType {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .custom:
            return "Custom"
        }
    }
    var imageName: String {
        switch mealType {
        case .breakfast:
            return "breakfast"
        case .lunch:
            return "lunch"
        case .dinner:
            return "dinner"
        case .custom:
            return "custom"
        }
    }
}

enum MealType: Codable {
    case breakfast
    case lunch
    case dinner
    case custom
}
