//
//  Recipe.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class Recipe: Codable {
    
    let id: UUID
    var title: String
    var description: String
    var calories: Int?
    var cookTime: Int?
    // Day 2
    var isFavorite: Bool
    
    init(id: UUID = UUID(), title: String, description: String, calories: Int?, cookTime: Int?, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.calories = calories
        self.cookTime = cookTime
        self.isFavorite = isFavorite
    }
    
} // End of Class

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}
