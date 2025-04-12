//
//  Color.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import SwiftUI

extension Color {
    static var darkModeBgColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ?
                   UIColor.secondarySystemBackground :
                   UIColor.systemBackground
        })
    }
    
}
