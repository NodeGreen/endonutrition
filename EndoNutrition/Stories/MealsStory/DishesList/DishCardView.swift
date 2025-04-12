import SwiftUI
import Foundation

struct DishCardView: View {
    let dish: Dish
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.darkModeBgColor)
                .shadow(radius: 2, x: 0, y: 1)
            
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Spacer()
                    Text(dish.executionTimeString)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(dish.executionTimeColor)
                        .padding(.top, 8)
                        .padding(.trailing, 16)
                }
                HStack {
                    Text(dish.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.label))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    Spacer()
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Text("dish.ingredients.count".localizedFormat(arguments: dish.ingredientsCount, table: "Meals"))
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.label).opacity(0.4))
                        .padding(.bottom, 8)
                        .padding(.trailing, 16)
                }
            }
        }.padding(.vertical, 8)
    }
}

#Preview {
    VStack {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                DishCardView(dish: Dish(
                    name: "Pancake integrali",
                    mealType: .breakfast,
                    executionTime: .medium,
                    ingredients: [
                        Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
                        Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
                        Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
                        Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
                    ]
                ))
                    .aspectRatio(1, contentMode:.fill)
                DishCardView(dish: Dish(
                    name: "Pancake integrali",
                    mealType: .breakfast,
                    executionTime: .medium,
                    ingredients: [
                        Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
                        Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
                        Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
                        Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
                    ]
                ))
                    .aspectRatio(1, contentMode:.fill)
            }
        }.frame(height: 200)
    }
    .preferredColorScheme(.light)

    
    VStack {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                DishCardView(dish: Dish(
                    name: "Pancake integrali",
                    mealType: .breakfast,
                    executionTime: .medium,
                    ingredients: [
                        Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
                        Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
                        Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
                        Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
                    ]
                ))
                    .aspectRatio(1, contentMode:.fill)
                DishCardView(dish: Dish(
                    name: "Pancake integrali",
                    mealType: .breakfast,
                    executionTime: .medium,
                    ingredients: [
                        Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
                        Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
                        Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
                        Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
                    ]
                ))
                    .aspectRatio(1, contentMode:.fill)
            }
        }.frame(height: 200)
    }
    .preferredColorScheme(.dark)
}
