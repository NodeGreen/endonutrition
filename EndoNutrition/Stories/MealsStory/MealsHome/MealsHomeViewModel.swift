//
//  MealsHomeViewModel.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI
import Foundation

class MealsHomeViewModel: ObservableObject {
    @Published var meals: [Meal] = [
        Meal(id: 0, color: .blue, title: "Colazione", mealType: .breakfast),
        Meal(id: 1, color: .red, title: "Pranzo", mealType: .lunch),
        Meal(id: 2, color: .green, title: "Cena", mealType: .dinner)
    ]
    @Published var selectedCard: Meal? = nil
    @Published var hasInteracted: Bool = false
    
    func selectCard(_ card: Meal) {
        self.selectedCard = card
    }
}
