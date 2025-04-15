# EndoNutrition

EndoNutrition is a comprehensive iOS application designed to help users manage their nutrition by organizing meals, creating shopping lists, and storing important health documents in one convenient place.

> **Note:** This application is still under active development. I'm working on it gradually, adding features and refining the experience step by step.

## Features

### Meals Management
- Browse meals organized by type (breakfast, lunch, dinner)
- Interactive card-based meal selection interface with intuitive swipe gestures
- View detailed information about dishes including:
 - Preparation time
 - Ingredients list
 - Nutrition facts
 - Step-by-step preparation instructions
- Add, update, and delete dishes

### Shopping List
- Create and manage shopping lists based on selected recipes
- Organize items by category
- Track purchased items

### Documents
- Store and access nutrition-related documents
- Organize health records, meal plans, and medical information

## Technical Overview

EndoNutrition is built with:
- **SwiftUI** for the user interface
- **Core Data** for persistent storage
- **MVVM architecture** for clean separation of concerns
- **Localization support** for multiple languages (English, Italian)
- **Adaptive design** for various iOS devices

## Core Components

### Data Models
- **Meal**: Represents meal types (breakfast, lunch, dinner)
- **Dish**: Contains dish information including name, ingredients, preparation steps, and nutrition facts
- **CoreData Entities**: MealEntity, DishEntity, IngredientEntity, PreparationStepEntity

### User Interface
- **MealsHomeView**: Main screen with meal selection cards and dish lists
- **MealsSelectionView**: Interactive swipeable card interface for meal type selection
- **DishDetailsView**: Comprehensive view of dish information
- **DishListView**: Grid/list of available dishes
- **TabView**: Navigation between the main app sections

## Design Patterns

- **Repository Pattern**: Abstracts data operations through DishRepository and MealRepository
- **MVVM**: ViewModels manage business logic and state
- **Dependency Injection**: Services and repositories are injected where needed
- **Observer Pattern**: Using SwiftUI's @Published and @Binding for reactive updates

## Requirements

- iOS 16.6+
- Xcode 16.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open EndoNutrition.xcodeproj in Xcode
3. Build and run the application on your device or simulator

## Future Enhancements

- Recipe recommendation based on dietary preferences
- Integration with health tracking systems
- Meal planning calendar
- Barcode scanning for shopping lists
- Nutritional goals and progress tracking

---

EndoNutrition is designed to provide a seamless experience for managing dietary needs while maintaining a clean, intuitive interface. The application emphasizes visual appeal and ease of use while providing powerful organization tools for health-conscious users.
