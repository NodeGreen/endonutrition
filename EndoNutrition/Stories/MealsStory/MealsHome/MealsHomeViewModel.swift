import SwiftUI
import Foundation

class MealsHomeViewModel: ObservableObject {
    private let dataManager = DataManager.shared
    private let mealRepository: MealRepository
    private let dishRepository: DishRepository
    
    var localMeals: [Meal] = []
    
    @Published var selectedMeal: Meal = Meal(id: 0, mealType: .breakfast)
    @Published var mealDishes: [Dish] = []
    @Published var hasInteracted: Bool = false
    
    init() {
        self.mealRepository = dataManager.mealRepository
        self.dishRepository = dataManager.dishRepository
        
        // Inizializza il database al primo avvio
        dataManager.setupDatabase()
    }
         
    func setup() {
        self.selectedMeal = getSelectedMealType()
        self.mealDishes = getMealDishes()
        self.localMeals = reorderMealsWithSelected(self.selectedMeal)
    }
    
    func selectCard(_ meal: Meal) {
        self.selectedMeal = meal
        self.mealDishes = getMealDishes()
        self.hasInteracted = true
    }
    
    private func reorderMealsWithSelected(_ selectedMeal: Meal) -> [Meal] {
        let originalMeals = mealRepository.fetchAllMeals()
        
        guard let selectedIndex = originalMeals.firstIndex(where: { $0.id == selectedMeal.id }) else {
            return originalMeals
        }
        
        var newMeals: [Meal] = []
        
        newMeals.append(originalMeals[selectedIndex])
        
        if selectedIndex < originalMeals.count - 1 {
            newMeals.append(contentsOf: originalMeals[(selectedIndex + 1)...])
        }
        
        if selectedIndex > 0 {
            newMeals.append(contentsOf: originalMeals[0..<selectedIndex])
        }
        
        return newMeals
    }
    
    private func getSelectedMealType() -> Meal {
        var selectedMealType: MealType = .breakfast
        let currentHour = Calendar.current.component(.hour, from: Date())
        if currentHour < 12 {
            selectedMealType = .breakfast
        } else if currentHour < 18 {
            selectedMealType = .lunch
        } else {
            selectedMealType = .dinner
        }
        
        let meals = mealRepository.fetchAllMeals()
        return meals.first(where: { $0.mealType == selectedMealType }) ?? meals[0]
    }
    
    private func getMealDishes() -> [Dish] {
        dishRepository.getDishes(byMealType: selectedMeal.mealType)
    }
    
    // MARK: - CRUD Operations
    
    func addNewDish(_ dish: Dish) {
        if dishRepository.getDish(byName: dish.name) != nil {
            updateDish(dish)
        } else {
            _ = dishRepository.createDish(from: dish)
            self.mealDishes = getMealDishes()
        }
    }
    
    func updateDish(_ dish: Dish) {
        _ = dishRepository.updateDish(dish)
        self.mealDishes = getMealDishes()
    }
    
    func deleteDish(name: String) {
        dishRepository.deleteDish(byName: name)
        self.mealDishes = getMealDishes()
    }
    
    func getDishByName(_ name: String) -> Dish? {
        dishRepository.getDish(byName: name)
    }
}
