//
//  MealsHomeView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//
import SwiftUI

struct MealsHomeView: View {
    @StateObject private var viewModel = MealsHomeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
 
                MealsSelectionView(
                    cards: $viewModel.localMeals,
                    hasInteracted: $viewModel.hasInteracted,
                    onCardSelected: { card in
                        viewModel.selectCard(card)
                    }
                )
                .frame(height: geometry.size.height * 0.70)
                .padding(.horizontal)
                
                DishListView(dishes: $viewModel.mealDishes)
                   
            }
        }.onAppear {
            viewModel.setup()
        }
    }
}

#Preview {
    MealsHomeView()
}
