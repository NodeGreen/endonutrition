//
//  DishListView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import Foundation
import SwiftUI

struct DishListView: View {
 
    @Binding var dishes: [Dish]
    @State private var navigateToFullList = false
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("dishes.title".localized(table: "Meals"))
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    navigateToFullList = true
                }) {
                    HStack(spacing: 4) {
                        Text("Vedi tutti")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(Color(UIColor.label))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule()
                            .fill(Color.darkModeBgColor)
                            .shadow(radius: 2, x: 0, y: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $navigateToFullList) {
                DishesFullListView(dishes: $dishes)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(Array(dishes.prefix(10))) { dish in
                        DishCardView(dish: dish)
                            .aspectRatio(1, contentMode: .fill)
                    }
                    
                }.padding(.horizontal)
            }
        }
    }
}

// MARK: - Preview
// Preview ottimizzata per la verifica
struct DishListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MealsSelectionViewContainer()
        }
    }
    
    // Container ottimizzato per il preview
    struct MealsSelectionViewContainer: View {
        
        @State private var dishes: [Dish] = [Dish(
            name: "Pancake integrali",
            mealType: .breakfast,
            executionTime: .medium,
            ingredients: [
                Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
                Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
                Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
                Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
            ]
        )]
        
        var body: some View {
            DishListView(dishes: $dishes)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(.systemGroupedBackground))
        
        }
    }
}

