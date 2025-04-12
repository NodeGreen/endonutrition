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
}
