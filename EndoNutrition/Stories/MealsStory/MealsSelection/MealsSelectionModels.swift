//
//  MealsSelectionModels.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI
import Foundation

struct Meal: Identifiable, Equatable {
    let id: Int
    let color: Color
    let title: String
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }
}
