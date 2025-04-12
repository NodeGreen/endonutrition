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
                    cards: $viewModel.meals,
                    hasInteracted: $viewModel.hasInteracted,
                    onCardSelected: { card in
                        viewModel.selectCard(card)
                    }
                )
                .frame(height: geometry.size.height * 0.65)
                
                DishListView(dishes: $viewModel.mealDishes)
                   
            }
            .padding()
        }.onAppear {
            viewModel.setup()
        }
    }
}

#Preview {
    MealsHomeView()
}
