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
    }
        
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
            // 1. Get the URL you want to save the data too
            guard let url = fileURL else {return}
            do {
                // 2. Convert the swift struct or class to JSON
                let data = try JSONEncoder().encode(categories)
                // 3. Save data from 2 to address from 1
                try data.write(to: url)
            } catch let error {
                print(error)
            }
        }
        
    func loadFromPersistentStore() {
            // 1. Get the URL you want to load the data from
            guard let url = fileURL else {return}
            do {
                // 2. Load the JSON data from that URL
                let data = try Data(contentsOf: url)
                // 3. Convert AKA Decode the JSON Data into our Custom Class
                let categories = try JSONDecoder().decode([RecipeCategory].self, from: data)
                // Set the SOT to the array we just decoded -> loaded
                self.categories = categories
            
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        // Computed Propery
        // A Computed Property is a property whose value is assigned the result of a computation. AKA a func.
        private var fileURL: URL? {
            // find the directory
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
            // Choose the url
            let url = documentsDirectory.appendingPathComponent("recipes.json")
            return url
        }
} // End of Class
