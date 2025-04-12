import SwiftUI
import Foundation

class MealsHomeViewModel: ObservableObject {
    // Definiamo prima i pasti come costante privata
    var meals: [Meal] = [
        Meal(id: 0, color: .blue, title: "Colazione", mealType: .breakfast),
        Meal(id: 1, color: .red, title: "Pranzo", mealType: .lunch),
        Meal(id: 2, color: .green, title: "Cena", mealType: .dinner)
    ]
    
    private let dishes: [Dish] = [
        // Colazione
        Dish(name: "Pancake integrali", mealType: .breakfast),
        Dish(name: "Yogurt greco con frutta", mealType: .breakfast),
        Dish(name: "Porridge con frutta secca", mealType: .breakfast),
        Dish(name: "Uova strapazzate", mealType: .breakfast),
        Dish(name: "Smoothie bowl", mealType: .breakfast),
        
        // Pranzo
        Dish(name: "Insalata di quinoa", mealType: .lunch),
        Dish(name: "Bowl di riso e verdure", mealType: .lunch),
        Dish(name: "Wrap di pollo", mealType: .lunch),
        Dish(name: "Zuppa di legumi", mealType: .lunch),
        Dish(name: "Pasta integrale al pesto", mealType: .lunch),
        
        // Cena
        Dish(name: "Salmone al forno", mealType: .dinner),
        Dish(name: "Tofu saltato con verdure", mealType: .dinner),
        Dish(name: "Frittata alle verdure", mealType: .dinner),
        Dish(name: "Insalata di farro", mealType: .dinner),
        Dish(name: "Pollo grigliato", mealType: .dinner)
    ]
    
    // Le proprietà pubblicate
    @Published var selectedMeal: Meal = Meal(id: 0, color: .blue, title: "Colazione", mealType: .breakfast)
    @Published var mealDishes: [Dish] = []
    @Published var hasInteracted: Bool = false
         
    func setup() {
        self.selectedMeal = getSelectedMealType()
        self.mealDishes = getMealDishes()
        self.meals = reorderMealsWithSelected(self.selectedMeal)
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
