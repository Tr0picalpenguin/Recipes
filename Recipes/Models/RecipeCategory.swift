//
//  RecipeCategory.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation
import CoreText

class RecipeCategory {
    
    var title: String
    var recipes: [Recipe]
    
    init(title: String, recipes: [Recipe] = []) {
        self.title = title
        self.recipes = recipes
    }
}// End of Class
