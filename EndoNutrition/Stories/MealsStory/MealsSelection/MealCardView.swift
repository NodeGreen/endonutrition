//
//  MealCardView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//


import SwiftUI

struct MealCardView: View {
    let meal: Meal
    let isTopCard: Bool
    let offset: CGFloat
    let cornerRadius: CGFloat
    let index: Int
    let offsetY: CGFloat
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Immagine con bordi arrotondati
            Image(meal.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]),
                startPoint: .top,
                endPoint: .center
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            Text(meal.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.top, .leading], 16)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
        }
        .shadow(radius: 5)
        .offset(x: offset, y: offsetY)
    }
}

#Preview {
    MealCardView(meal: Meal(id: 0, mealType: .lunch), isTopCard: true, offset: 0, cornerRadius: 20, index: 0, offsetY: 0)
}
