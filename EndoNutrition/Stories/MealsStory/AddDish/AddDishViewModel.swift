//
//  AddDishViewModel.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//

import Foundation
import SwiftUI
import Combine

class AddDishViewModel: ObservableObject {
    private let dataManager = DataManager.shared
    private let dishRepository: DishRepository
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var mealType: MealType = .breakfast
    @Published var executionTime: Dish.ExecutionTime = .medium
    @Published var ingredients: [Dish.Ingredients] = []
    @Published var nutritionFacts: [String: String] = [:]
    @Published var preparationSteps: [Dish.PreparationStep] = []
    
    private var originalDish: Dish?
    
    init() {
        self.dishRepository = dataManager.dishRepository
    }
    
    func loadDish(_ dish: Dish) {
        self.originalDish = dish
        self.name = dish.name
        self.description = dish.description ?? ""
        self.mealType = dish.mealType
        self.executionTime = dish.executionTime
        self.ingredients = dish.ingredients
        self.nutritionFacts = dish.nutritionFacts ?? [:]
        self.preparationSteps = dish.preparationSteps ?? []
    }
    
    func saveDish() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validazione dei dati
        guard !trimmedName.isEmpty && !ingredients.isEmpty else {
            print("Mancano dati essenziali: nome o ingredienti")
            return
        }
        
        let newDish = Dish(
            name: trimmedName,
            mealType: mealType,
            executionTime: executionTime,
            ingredients: ingredients,
            description: description.isEmpty ? nil : description.trimmingCharacters(in: .whitespacesAndNewlines),
            nutritionFacts: nutritionFacts.isEmpty ? nil : nutritionFacts,
            preparationSteps: preparationSteps.isEmpty ? nil : preparationSteps
        )
        
        _ = dishRepository.createDish(from: newDish)
    }
    
    func updateDish() {
        guard let _ = originalDish else { return }
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validazione dei dati
        guard !trimmedName.isEmpty && !ingredients.isEmpty else {
            print("Mancano dati essenziali: nome o ingredienti")
            return
        }
        
        let updatedDish = Dish(
            name: trimmedName,
            mealType: mealType,
            executionTime: executionTime,
            ingredients: ingredients,
            description: description.isEmpty ? nil : description.trimmingCharacters(in: .whitespacesAndNewlines),
            nutritionFacts: nutritionFacts.isEmpty ? nil : nutritionFacts,
            preparationSteps: preparationSteps.isEmpty ? nil : preparationSteps
        )
        
        _ = dishRepository.updateDish(updatedDish)
    }
    
    func removeIngredient(_ ingredient: Dish.Ingredients) {
        ingredients.removeAll { $0.id == ingredient.id }
    }
    
    func removeNutritionFact(key: String) {
        nutritionFacts.removeValue(forKey: key)
    }
    
    func removeStep(_ step: Dish.PreparationStep) {
        preparationSteps.removeAll { $0.id == step.id }
    }
}
