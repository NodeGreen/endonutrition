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
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("dishes.title".localized(table: "Meals"))
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(Array(dishes.prefix(10))) { dish in
                        DishCardView(title: dish.name)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

// Preview ottimizzata per la verifica
struct DishListView_Previews: PreviewProvider {
    static var previews: some View {
        MealsSelectionViewContainer()
    }
    
    // Container ottimizzato per il preview
    struct MealsSelectionViewContainer: View {
        
        @State private var dishes: [Dish] = []
        
        var body: some View {
            DishListView(dishes: $dishes)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(.systemGroupedBackground))
        
        }
    }
}
