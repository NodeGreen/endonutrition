//
//  String.swift
//  EndoNutrition
//
//  Created by Endo on 12/04/25.
//

import Foundation

public extension String {
    
    func localized(table: String = "Localizable", bundle: Bundle = .main, comment: String = "") -> String {
           return NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: comment)
    }
       
   func localizedFormat(arguments: CVarArg..., table: String = "Localizable", bundle: Bundle = .main, comment: String = "") -> String {
           let format = NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: comment)
           return String(format: format, arguments: arguments)
       }
}
