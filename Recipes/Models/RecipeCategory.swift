//
//  RecipeCategory.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation
import CoreText

class RecipeCategory {
    
    let id: UUID
    var title: String
    var recipes: [Recipe]
    
    init(id: UUID = UUID(), title: String, recipes: [Recipe] = []) {
        self.id = id
        self.title = title
        self.recipes = recipes
    }
}// End of Class

extension RecipeCategory: Equatable {
    static func == (lhs: RecipeCategory, rhs: RecipeCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
