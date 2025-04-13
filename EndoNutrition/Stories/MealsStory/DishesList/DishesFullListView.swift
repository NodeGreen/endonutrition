//
//  DishesFullListView.swift
//  EndoNutrition
//
//  Created by Endo on 13/04/25.
//

import SwiftUI

struct DishesFullListView: View {
    @Binding var dishes: [Dish]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 8) {
                ForEach(dishes) { dish in
                    DishCardView(dish: dish)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding()
        }
    }
}

