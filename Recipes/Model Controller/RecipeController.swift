//
//  RecipeController.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class RecipeController {
    
    // MARK: - Singleton
    static let sharedInstance = RecipeController()
    
    // MARK: - Source of Truth
    private(set) var categories: [RecipeCategory] = []
    
    // MARK: - CRUD
    
    // MARK: - Categories
    func createRecipeCategory(title: String = "Untitled Category") {
        // create the Object
        let category = RecipeCategory(title: title)
        // Add it to SOT
        categories.append(category)
        // Save it
        saveToPersistentStore()
        
        func updateRecipeCategory(recipeToUpdate: Recipe, title: String) {
            // Update the values
            recipeToUpdate.title = title
            // <---- Assign the value of 'newTitle' to the property 'title' of the 'categoryToUpdate/ object.
            // Save
            saveToPersistentStore()
        }
        
        func delete(categoryToDelete: RecipeCategory) {
            // Remove from the array
            guard let index = categories.firstIndex(of: categoryToDelete) else {return}
            categories.remove(at: index)
            // Save
            saveToPersistentStore()
        }
        
        // MARK: - Recipes
        func createRecipe(title: String = "Untitled Recipe", description: String = "Resipe Description", calories: Int = 0, cookTime: Int = 0, in category: RecipeCategory) {
            let recipe = Recipe(title: title, description: description, calories: calories, cookTime: cookTime)
            category.recipes.append(recipe)
            saveToPersistentStore()
        }
        
        func updateRecipe(recipeToUpdate: Recipe, newTitle: String, newDescription: String, newCalories: Int?, newCookTime: Int?) {
            recipeToUpdate.title = newTitle
            recipeToUpdate.description = newDescription
            recipeToUpdate.calories = newCalories
            recipeToUpdate.cookTime = newCookTime
            // Save
            saveToPersistentStore()
        }
        
        func deleteRecipe(recipe recipeToDelete: Recipe, from category: RecipeCategory) {
            // Remove from the array
            guard let index = category.recipes.firstIndex(of: recipeToDelete) else {return}
            category.recipes.remove(at: index)
            // Save
            saveToPersistentStore()
            
        }
        
        // MARK: - Persistence
        
        func saveToPersistentStore() {
            
        }
        
        func loadFromPersistentStore() {
            
        }
        
    }
} // End of Class
