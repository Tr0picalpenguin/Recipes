//
//  Recipe.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class Recipe {
    
    var title: String
    var description: String
    var calories: Int?
    var cookTime: Int?
    
    init(title: String, description: String, calories: Int?, cookTime: Int?) {
        self.title = title
        self.description = description
        self.calories = calories
        self.cookTime = cookTime
    }
    
} // End of Class
