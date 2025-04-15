//
//  MealRepository.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//


import Foundation
import CoreData

class MealRepository {
    private let coreDataManager = CoreDataManager.shared
    
    func fetchAllMeals() -> [Meal] {
        let meals = coreDataManager.fetch(MealEntity.self)
        return meals.map { mapMealEntityToMeal($0) }
    }
    
    func getMeal(byId id: Int) -> Meal? {
        let predicate = coreDataManager.createPredicate(format: "id == %d", arguments: [id])
        guard let mealEntity = coreDataManager.fetchFirst(MealEntity.self, predicate: predicate) else {
            return nil
        }
        
        return mapMealEntityToMeal(mealEntity)
    }
    
    func getMealsByType(_ type: MealType) -> [Meal] {
        let predicate = coreDataManager.createPredicate(format: "mealType == %@", arguments: [type])
        let meals = coreDataManager.fetch(MealEntity.self, predicate: predicate)
        return meals.map { mapMealEntityToMeal($0) }
    }
    
    func createMeal(id: Int, mealType: MealType) -> Meal {
        let entity = coreDataManager.create(MealEntity.self)
        entity.id = Int64(id)
        entity.mealType = mealType.rawValue
        
        coreDataManager.saveContext()
        return mapMealEntityToMeal(entity)
    }
    
    func createMealIfNotExists(id: Int, mealType: MealType) -> Meal {
        if let existingMeal = getMeal(byId: id) {
            return existingMeal
        } else {
            return createMeal(id: id, mealType: mealType)
        }
    }
    
    func updateMeal(_ meal: Meal) -> Meal? {
        let predicate = coreDataManager.createPredicate(format: "id == %d", arguments: [meal.id])
        guard let entity = coreDataManager.fetchFirst(MealEntity.self, predicate: predicate) else {
            return nil
        }
        
        entity.mealType = meal.mealType.rawValue
        coreDataManager.saveContext()
        
        return mapMealEntityToMeal(entity)
    }
    
    func deleteMeal(id: Int) {
        let predicate = coreDataManager.createPredicate(format: "id == %d", arguments: [id])
        if let entity = coreDataManager.fetchFirst(MealEntity.self, predicate: predicate) {
            coreDataManager.delete(entity)
        }
    }
    
    func deleteAllMeals() {
        coreDataManager.deleteAll(MealEntity.self)
    }
    
    // MARK: - Helper Methods
    
    private func mapMealEntityToMeal(_ entity: MealEntity) -> Meal {
        let mealType = MealType(rawValue: entity.mealType ?? "breakfast") ?? .breakfast
        return Meal(id: Int(entity.id), mealType: mealType)
    }
    
    // MARK: - Initialization Data
    
    func populateInitialMeals() {
        let count = coreDataManager.count(MealEntity.self)
        
        if count == 0 {
            let initialMeals: [Meal] = [
                Meal(id: 0, mealType: .breakfast),
                Meal(id: 1, mealType: .lunch),
                Meal(id: 2, mealType: .dinner)
            ]
            
            for meal in initialMeals {
                _ = createMeal(id: meal.id, mealType: meal.mealType)
            }
        }
    }
}
