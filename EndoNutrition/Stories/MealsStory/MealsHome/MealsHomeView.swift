//
//  MealsHomeView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI

struct MealsHomeView: View {
    
    @State private var selectedCard: Meal? = nil
    @State private var meals: [Meal] = [
        Meal(id: 0, color: .blue, title: "Colazione"),
        Meal(id: 1, color: .red, title: "Pranzo"),
        Meal(id: 2, color: .green, title: "Cena")
    ]
    @State private var hasInteracted: Bool = false

    var body: some View {
        VStack {
            MealsSelectionView (cards: $meals, hasInteracted: $hasInteracted, onCardSelected: { card in
                self.selectedCard = card
            })
            Spacer()
        }
    }
}

#Preview {
    MealsHomeView()
}
