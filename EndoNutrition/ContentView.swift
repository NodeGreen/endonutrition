//
//  ContentView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MealsHomeView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("mealshome.title".localized(table: "Meals"))
                }
            
            ShoppingListHomeView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("shoppinglisthome.title".localized(table: "ShoppingList"))

                }
            DocumentsHomeView()
                .tabItem {
                    Image(systemName: "document")
                    Text("documentshome.title".localized(table: "Documents"))

                }
        }
    }
}

#Preview {
    ContentView()
}
