//
//  DataManager.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//


import Foundation

class DataManager {
    static let shared = DataManager()
    
    let mealRepository = MealRepository()
    let dishRepository = DishRepository()
    
    private init() {}
    
    func setupDatabase() {
        // Inizializzazione del database con i dati predefiniti
        mealRepository.populateInitialMeals()
    }
    
    private func getInitialDishes() -> [Dish] {
        // Qui inserisci la lista di piatti predefiniti che avevi nel codice originale
        return []
    }
}
