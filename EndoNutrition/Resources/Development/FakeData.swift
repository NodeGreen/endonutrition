//
//  FakeData.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//
import Foundation

let meals: [Meal] = [
    Meal(id: 0, mealType: .breakfast),
    Meal(id: 1, mealType: .lunch),
    Meal(id: 2, mealType: .dinner)
]

let dishes: [Dish] = [
    // Colazione
    Dish(
        name: "Pancake integrali",
        mealType: .breakfast,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
            Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
            Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Yogurt greco con frutta",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Yogurt greco", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Mirtilli", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Banana", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Miele", quantity: 10, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Porridge con frutta secca",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Fiocchi d'avena", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
            Dish.Ingredients(name: "Mandorle", quantity: 15, quantityType: .grams),
            Dish.Ingredients(name: "Datteri", quantity: 3, quantityType: .number)
        ]
    ),
    
    Dish(
        name: "Uova strapazzate",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Uova", quantity: 3, quantityType: .number),
            Dish.Ingredients(name: "Latte", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Sale", quantity: 2, quantityType: .grams),
            Dish.Ingredients(name: "Pepe", quantity: 1, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Smoothie bowl",
        mealType: .breakfast,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Banana", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Fragole", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Yogurt", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Semi di chia", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Latte di mandorla", quantity: 100, quantityType: .grams)
        ]
    ),
    
    // Pranzo
    Dish(
        name: "Insalata di quinoa",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Quinoa", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Cetriolo", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Avocado", quantity: 0.5, quantityType: .number),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 15, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Bowl di riso e verdure",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Riso integrale", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Zucchine", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Peperoni", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Salsa di soia", quantity: 10, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Wrap di pollo",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Tortilla integrale", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Petto di pollo", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Insalata", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Pomodoro", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Yogurt greco", quantity: 30, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Zuppa di legumi",
        mealType: .lunch,
        executionTime: .slow,
        ingredients: [
            Dish.Ingredients(name: "Lenticchie", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Sedano", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Cipolla", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Brodo vegetale", quantity: 500, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Pasta integrale al pesto",
        mealType: .lunch,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Pasta integrale", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Pesto", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Parmigiano", quantity: 10, quantityType: .grams)
        ]
    ),
    
    // Cena
    Dish(
        name: "Salmone al forno",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Filetto di salmone", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Limone", quantity: 0.5, quantityType: .number),
            Dish.Ingredients(name: "Aneto", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Sale", quantity: 2, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Tofu saltato con verdure",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Tofu", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Broccoli", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Salsa di soia", quantity: 15, quantityType: .grams),
            Dish.Ingredients(name: "Zenzero", quantity: 5, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Frittata alle verdure",
        mealType: .dinner,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Uova", quantity: 3, quantityType: .number),
            Dish.Ingredients(name: "Zucchine", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Cipolla", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Formaggio", quantity: 30, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Insalata di farro",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Farro", quantity: 70, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Rucola", quantity: 40, quantityType: .grams),
            Dish.Ingredients(name: "Mozzarella", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Basilico", quantity: 5, quantityType: .grams)
        ]
    ),
    
    Dish(
        name: "Pollo grigliato",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Petto di pollo", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Rosmarino", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Aglio", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Limone", quantity: 0.5, quantityType: .number)
        ]
    )
]
