//
//  AddDishButton.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//

import SwiftUI

struct AddDishButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: {
            // Azione per aggiungere un piatto
        }) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                
                Text("Aggiungi Piatto")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .pink, .purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
            .shadow(
                color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.orange.opacity(0.5),
                radius: colorScheme == .dark ? 8 : 6,
                x: 0,
                y: colorScheme == .dark ? 4 : 3
            )
        }
    }
}

#Preview {
    VStack {
        AddDishButton()
            .padding()
        
        AddDishButton()
            .padding()
            .preferredColorScheme(.dark)
    }
    .padding()
}
