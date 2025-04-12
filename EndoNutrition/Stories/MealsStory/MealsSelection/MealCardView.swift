//
//  MealCardView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//


import SwiftUI

struct MealCardView: View {
    // Parametri di sola lettura per ottimizzare la ricostruzione
    let card: Meal
    let isTopCard: Bool
    let offset: CGFloat
    let cornerRadius: CGFloat
    let height: CGFloat
    let index: Int
    
    // Rendimento ottimizzato evitando ricalcoli inutili
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(card.color)
            .overlay(
                Text(card.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    // Ottimizzazione rendering testo
                    .fixedSize(horizontal: false, vertical: true)
            )
            .frame(height: height)
            .padding(.horizontal)
            // Ottimizzazione shadow (raggio ridotto)
            .shadow(radius: 2)
            // Offset condizionale per evitare calcoli inutili
            .if(isTopCard) { view in
                view.offset(x: offset)
            }
    }
}

#Preview {
    MealCardView(card: Meal(id: 0, color: .red, title: "Pasto", mealType: .lunch), isTopCard: true, offset: 0, cornerRadius: 20, height: 450, index: 0)
}
