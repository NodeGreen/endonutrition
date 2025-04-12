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
        VStack {
            MealsSelectionView(
                cards: $viewModel.meals,
                hasInteracted: $viewModel.hasInteracted,
                onCardSelected: { card in
                    viewModel.selectCard(card)
                }
            )
            Spacer()
        }
    }
}

#Preview {
    MealsHomeView()
}
