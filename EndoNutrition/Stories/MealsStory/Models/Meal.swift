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
            return "meal.type.breakfast".localized(table: "Meals")
        case .lunch:
            return "meal.type.lunch".localized(table: "Meals")
        case .dinner:
            return "meal.type.dinner".localized(table: "Meals")
        case .custom:
            return "meal.type.custom".localized(table: "Meals")
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

enum MealType: String, Codable {
    case breakfast
    case lunch
    case dinner
    case custom
}
