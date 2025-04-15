//
//  DishRepository.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//

import Foundation
import CoreData

class DishRepository {
    private let coreDataManager = CoreDataManager.shared
    
    func fetchAllDishes() -> [Dish] {
        let dishes = coreDataManager.fetch(DishEntity.self)
        return dishes.map { mapDishEntityToDish($0) }
    }
    
    func getDishes(byMealType mealType: MealType) -> [Dish] {
        let predicate = coreDataManager.createPredicate(format: "mealType == %@", arguments: [mealType.rawValue])
        let dishes = coreDataManager.fetch(DishEntity.self, predicate: predicate)
        return dishes.map { mapDishEntityToDish($0) }
    }
    
    func getDish(byName name: String) -> Dish? {
        let predicate = coreDataManager.createPredicate(format: "name == %@", arguments: [name])
        guard let entity = coreDataManager.fetchFirst(DishEntity.self, predicate: predicate) else {
            return nil
        }
        
        return mapDishEntityToDish(entity)
    }
    
    func createDish(from dish: Dish) -> Dish {
        // Crea l'entità principale del piatto
        let entity = coreDataManager.create(DishEntity.self)
        entity.name = dish.name
        entity.mealType = dish.mealType.rawValue
        entity.dishDescription = dish.description
        entity.executionTime = dish.executionTime.rawValue
        
        // Crea le entità degli ingredienti
        for ingredient in dish.ingredients {
            let ingredientEntity = coreDataManager.create(IngredientEntity.self)
            ingredientEntity.name = ingredient.name
            ingredientEntity.quantity = ingredient.quantity
            ingredientEntity.quantityType = ingredient.quantityType.rawValue
            ingredientEntity.dish = entity
        }
        
        // Salva i fatti nutrizionali come data JSON
        if let nutritionFacts = dish.nutritionFacts, !nutritionFacts.isEmpty {
            // Assicuriamoci che tutti i valori siano stringhe
            let safeNutritionFacts = nutritionFacts.mapValues { value -> String in
                if let stringValue = value as? String {
                    return stringValue
                }
                return String(describing: value)
            }
            
            if let nutritionData = try? JSONSerialization.data(withJSONObject: safeNutritionFacts, options: []) {
                entity.nutritionFacts = nutritionData
            }
        }
        
        // Crea le entità dei passaggi di preparazione
        if let preparationSteps = dish.preparationSteps, !preparationSteps.isEmpty {
            for (index, step) in preparationSteps.enumerated() {
                let stepEntity = coreDataManager.create(PreparationStepEntity.self)
                stepEntity.title = step.title
                stepEntity.stepDescription = step.description
                stepEntity.order = Int16(index)
                stepEntity.dish = entity
            }
        }
        
        coreDataManager.saveContext()
        return mapDishEntityToDish(entity)
    }
    
    func updateDish(_ dish: Dish) -> Dish? {
        let predicate = coreDataManager.createPredicate(format: "name == %@", arguments: [dish.name])
        guard let entity = coreDataManager.fetchFirst(DishEntity.self, predicate: predicate) else {
            return nil
        }
        
        // Aggiorna l'entità principale
        entity.mealType = dish.mealType.rawValue
        entity.dishDescription = dish.description
        entity.executionTime = dish.executionTime.rawValue
        
        // Elimina gli ingredienti esistenti
        if let ingredients = entity.ingredients as? Set<IngredientEntity> {
            for ingredient in ingredients {
                coreDataManager.delete(ingredient)
            }
        }
        
        // Crea i nuovi ingredienti
        for ingredient in dish.ingredients {
            let ingredientEntity = coreDataManager.create(IngredientEntity.self)
            ingredientEntity.name = ingredient.name
            ingredientEntity.quantity = ingredient.quantity
            ingredientEntity.quantityType = ingredient.quantityType.rawValue
            ingredientEntity.dish = entity
        }
        
        // Aggiorna i fatti nutrizionali
        if let nutritionFacts = dish.nutritionFacts, !nutritionFacts.isEmpty {
            // Assicuriamoci che tutti i valori siano stringhe
            let safeNutritionFacts = nutritionFacts.mapValues { value -> String in
                if let stringValue = value as? String {
                    return stringValue
                }
                return String(describing: value)
            }
            
            if let nutritionData = try? JSONSerialization.data(withJSONObject: safeNutritionFacts, options: []) {
                entity.nutritionFacts = nutritionData
            }
        } else {
            entity.nutritionFacts = nil
        }
        
        // Elimina i passaggi di preparazione esistenti
        if let steps = entity.preparationSteps as? Set<PreparationStepEntity> {
            for step in steps {
                coreDataManager.delete(step)
            }
        }
        
        // Crea i nuovi passaggi di preparazione
        if let preparationSteps = dish.preparationSteps, !preparationSteps.isEmpty {
            for (index, step) in preparationSteps.enumerated() {
                let stepEntity = coreDataManager.create(PreparationStepEntity.self)
                stepEntity.title = step.title
                stepEntity.stepDescription = step.description
                stepEntity.order = Int16(index)
                stepEntity.dish = entity
            }
        }
        
        coreDataManager.saveContext()
        return mapDishEntityToDish(entity)
    }
    
    func deleteDish(byName name: String) {
        let predicate = coreDataManager.createPredicate(format: "name == %@", arguments: [name])
        if let entity = coreDataManager.fetchFirst(DishEntity.self, predicate: predicate) {
            coreDataManager.delete(entity)
        }
    }
    
    func deleteAllDishes() {
        coreDataManager.deleteAll(DishEntity.self)
    }
    
    // MARK: - Helper Methods
    
    private func mapDishEntityToDish(_ entity: DishEntity) -> Dish {
        // Converti gli ingredienti
        var ingredients: [Dish.Ingredients] = []
        if let ingredientsSet = entity.ingredients as? Set<IngredientEntity> {
            ingredients = ingredientsSet.map { ingredientEntity in
                let quantityType = Dish.QuantityType(rawValue: ingredientEntity.quantityType ?? "grams") ?? .grams
                return Dish.Ingredients(
                    name: ingredientEntity.name ?? "",
                    quantity: ingredientEntity.quantity,
                    quantityType: quantityType
                )
            }
        }
        
        // Converti i passaggi di preparazione
        var preparationSteps: [Dish.PreparationStep] = []
        if let stepsSet = entity.preparationSteps as? Set<PreparationStepEntity> {
            let sortedSteps = stepsSet.sorted { $0.order < $1.order }
            preparationSteps = sortedSteps.map { stepEntity in
                Dish.PreparationStep(
                    title: stepEntity.title ?? "",
                    description: stepEntity.stepDescription ?? ""
                )
            }
        }
        
        // Converti i fatti nutrizionali
        var nutritionFacts: [String: String] = [:]
        if let nutritionData = entity.nutritionFacts, !nutritionData.isEmpty {
            do {
                if let dict = try JSONSerialization.jsonObject(with: nutritionData, options: []) as? [String: String] {
                    nutritionFacts = dict
                }
            } catch {
                print("Errore nel convertire i dati nutrizionali JSON: \(error)")
            }
        }
        
        let executionTime = Dish.ExecutionTime(rawValue: entity.executionTime ?? "medium") ?? .medium
        let mealType = MealType(rawValue: entity.mealType ?? "breakfast") ?? .breakfast
        
        return Dish(
            name: entity.name ?? "",
            mealType: mealType,
            executionTime: executionTime,
            ingredients: ingredients,
            description: entity.dishDescription,
            nutritionFacts: nutritionFacts.isEmpty ? nil : nutritionFacts,
            preparationSteps: preparationSteps.isEmpty ? nil : preparationSteps
        )
    }
    
    // MARK: - Initialization Data
    
    func populateInitialDishes(dishes: [Dish]) {
        let count = coreDataManager.count(DishEntity.self)
        
        if count == 0 {
            for dish in dishes {
                _ = createDish(from: dish)
            }
        }
    }
}
