//
//  EndoNutritionApp.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI

@main
struct EndoNutritionApp: App {
    
    init() {
        _ = CoreDataManager.shared
        DataManager.shared.setupDatabase()
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
