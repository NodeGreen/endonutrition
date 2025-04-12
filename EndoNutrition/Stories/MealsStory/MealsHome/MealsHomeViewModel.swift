import SwiftUI
import Foundation

class MealsHomeViewModel: ObservableObject {
    // Le proprietà pubblicate
    
    var localMeals: [Meal] = []
    
    @Published var selectedMeal: Meal = Meal(id: 0, mealType: .breakfast)
    @Published var mealDishes: [Dish] = []
    @Published var hasInteracted: Bool = false
         
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

        let originalMeals = meals
        
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
        
        return meals.filter({$0.mealType == selectedMealType}).first ?? meals[0]
    }
    
    private func getMealDishes() -> [Dish] {
        dishes.filter({ $0.mealType == selectedMeal.mealType })
    }
}
