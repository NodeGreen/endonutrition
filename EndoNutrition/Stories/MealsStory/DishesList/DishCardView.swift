//
//  DishCardView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI
import Foundation

struct DishCardView: View {
    let title: String
    
    // Funzione per generare un colore pastello casuale
    private var pastelColor: Color {
        let pastelColors: [Color] = [
            Color(red: 0.95, green: 0.8, blue: 0.8),   // Rosa pastello
            Color(red: 0.8, green: 0.95, blue: 0.8),   // Verde menta
            Color(red: 0.8, green: 0.8, blue: 0.95),   // Azzurro pastello
            Color(red: 0.95, green: 0.95, blue: 0.8),  // Giallo pastello
            Color(red: 0.95, green: 0.8, blue: 0.95),  // Lilla pastello
            Color(red: 0.8, green: 0.95, blue: 0.95),  // Celeste pastello
            Color(red: 0.9, green: 0.85, blue: 0.7)    // Beige pastello
        ]
        
        return pastelColors.randomElement() ?? Color(red: 0.9, green: 0.9, blue: 0.9)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(pastelColor)
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(8)
        }
    }
}

#Preview {
    DishCardView(title: "Primo")
}
