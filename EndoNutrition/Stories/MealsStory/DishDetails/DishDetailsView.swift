import SwiftUI

struct DishDetailsView: View {
    let dish: Dish
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                DishHeaderView(dish: dish)
                
                DishIngredientsView(ingredients: dish.ingredients)
                
                DishNutritionView(nutritionFacts: dish.nutritionFacts)
                
                DishPreparationView(preparationSteps: dish.preparationSteps)
            }
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct DishHeaderView: View {
    let dish: Dish
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.darkModeBgColor
                .frame(height: 300)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            VStack {
                Circle()
                    .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
                    .frame(width: 240, height: 240)
                    .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.1),
                            radius: colorScheme == .dark ? 10 : 8,
                            x: 0,
                            y: colorScheme == .dark ? 6 : 4)
                    .overlay(
                        Image(systemName: "fork.knife")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.systemGray2) : Color.gray)
                            .frame(width: 80, height: 80)
                    )
                    .padding(.top, 40)
                
                Text(dish.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 36)
                    .padding(.bottom, 4)
                
                if let description = dish.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 16)
                }
            }
        }
    }
}

struct DishIngredientsView: View {
    let ingredients: [Dish.Ingredients]
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Ingredienti")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
            }
            .padding(.horizontal)
            
            if ingredients.isEmpty {
                AddButtonView(title: "Aggiungi Ingredienti")
                    .padding(.horizontal)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            IngredientItemView(ingredient: ingredients[index])
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct IngredientItemView: View {
    let ingredient: Dish.Ingredients
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "leaf")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                )
            
            Text(ingredient.name)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor.label))
            
            Text("\(Int(ingredient.quantity)) \(ingredient.quantityType)")
                .font(.caption2)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
        .frame(width: 80)
    }
}

struct DishNutritionView: View {
    let nutritionFacts: [String: String]?
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Fatti Nutrizionali")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
                .padding(.horizontal)
            
            if let facts = nutritionFacts, !facts.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(facts.keys.sorted()), id: \.self) { key in
                        if let value = facts[key] {
                            NutritionItemView(label: key, value: value)
                            
                            if key != facts.keys.sorted().last {
                                Divider()
                                    .background(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.gray.opacity(0.2))
                            }
                        }
                    }
                }
                .padding()
                .background(Color.darkModeBgColor)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.2) : Color.black.opacity(0.05),
                        radius: colorScheme == .dark ? 7 : 5,
                        x: 0,
                        y: colorScheme == .dark ? 3 : 2)
                .padding(.horizontal)
            } else {
                AddButtonView(title: "Aggiungi Fatti Nutrizionali")
                    .padding(.horizontal)
            }
        }
    }
}

struct NutritionItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.label))
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}

struct DishPreparationView: View {
    let preparationSteps: [Dish.PreparationStep]?
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preparazione")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
                .padding(.horizontal)
            
            if let steps = preparationSteps, !steps.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        PreparationStepView(step: steps[index], stepNumber: index + 1)
                        
                        if index < steps.count - 1 {
                            Divider()
                                .background(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.gray.opacity(0.2))
                        }
                    }
                }
                .padding()
                .background(Color.darkModeBgColor)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.2) : Color.black.opacity(0.05),
                        radius: colorScheme == .dark ? 7 : 5,
                        x: 0,
                        y: colorScheme == .dark ? 3 : 2)
                .padding(.horizontal)
            } else {
                AddButtonView(title: "Aggiungi Passaggi")
                    .padding(.horizontal)
            }
        }
    }
}

struct PreparationStepView: View {
    let step: Dish.PreparationStep
    let stepNumber: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text("\(stepNumber)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.blue)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
            Spacer()
        }
    }
}

struct AddButtonView: View {
    let title: String
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: {
            // Azione per aggiungere contenuto
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .shadow(
                color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.blue.opacity(0.4),
                radius: colorScheme == .dark ? 8 : 6,
                x: 0,
                y: colorScheme == .dark ? 4 : 3
            )
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    Group {
        NavigationStack {
            DishDetailsView(dish: Dish(
                name: "Salmone allo Zenzero e Mango",
                mealType: .lunch,
                executionTime: .medium,
                ingredients: [
                    Dish.Ingredients(name: "Salmone", quantity: 200, quantityType: .grams),
                    Dish.Ingredients(name: "Zenzero", quantity: 20, quantityType: .grams),
                    Dish.Ingredients(name: "Mango", quantity: 1, quantityType: .number),
                    Dish.Ingredients(name: "Limone", quantity: 1, quantityType: .number)
                ],
                description: "Questo salmone allo zenzero è veloce da preparare ed è pieno di sapore. È il pasto perfetto per la tua dieta bilanciata.",
                nutritionFacts: ["Calorie": "320 kcal", "Proteine": "25g", "Carboidrati": "18g", "Grassi": "14g"],
                preparationSteps: [
                    Dish.PreparationStep(title: "Preparare il salmone", description: "Sciacquare il salmone e asciugarlo con carta assorbente"),
                    Dish.PreparationStep(title: "Marinare", description: "Marinare il salmone con succo di limone, zenzero grattugiato e un pizzico di sale"),
                    Dish.PreparationStep(title: "Cuocere", description: "Cuocere in padella a fuoco medio per 4-5 minuti per lato fino a doratura")
                ]
            ))
        }
        .preferredColorScheme(.light)
        
        NavigationStack {
            DishDetailsView(dish: Dish(
                name: "Pancake integrali",
                mealType: .breakfast,
                executionTime: .medium,
                ingredients: [],
                description: "Deliziosi pancake integrali perfetti per una colazione sana ed energetica.",
                nutritionFacts: nil,
                preparationSteps: nil
            ))
        }
        .preferredColorScheme(.dark)
    }
}
