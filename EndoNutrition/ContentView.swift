//
//  ContentView.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MealsHomeView()
            }
            .tabItem {
                Image(systemName: "fork.knife")
                Text("meals.home.title".localized(table: "Meals"))
            }
            
            NavigationStack {
                ShoppingListHomeView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("shoppinglisthome.title".localized(table: "ShoppingList"))
            }
            
            NavigationStack {
                DocumentsHomeView()
            }
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
