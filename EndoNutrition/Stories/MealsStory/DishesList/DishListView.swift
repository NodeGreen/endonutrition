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
    @State private var showingAddDish = false
    
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
                        Text("dishes.see.all".localized(table: "Meals"))
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
                    
                    AddDishButtonView {
                        showingAddDish = true
                    }
                    .aspectRatio(1, contentMode: .fill)
                    
                }.padding(.horizontal)
            }
        }
        .sheet(isPresented: $showingAddDish) {
            AddDishView()
        }
    }
}

struct AddDishCardView: View {
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 2, x: 0, y: 1)
                
                VStack(spacing: 15) {
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color.purple)
                        )
                    
                    Text("Add New Dish")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }
                .padding()
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AddDishButtonView: View {
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.darkModeBgColor)
                    .shadow(radius: 2, x: 0, y: 1)
                
                VStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.blue)
                    }
                    
                    Text("Add Dish")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor.label))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }
                .padding()
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
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
            ], description: "test descrizione"
        )]
        
        var body: some View {
            DishListView(dishes: $dishes)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(.systemGroupedBackground))
        
        }
    }
}
