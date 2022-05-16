//
//  RecipeListTableViewController.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var category: RecipeCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category?.recipes.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        guard let category = category else {return cell}
        let recipe = category.recipes[indexPath.row]
        let calories = recipe.calories ?? 0
        cell.textLabel?.text = recipe.title
        cell.detailTextLabel?.text = "\(calories) Cal"
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let category = category else {return}
            let recipe = category.recipes[indexPath.row]
            
            RecipeController.sharedInstance.deleteRecipe(recipe: recipe, from: category)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        guard segue.identifier == "toRecipeDetailViewController",
              let destination = segue.destination as? RecipeDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        // Object to send
        let recipe = category?.recipes[indexPath.row]
        destination.recipe = recipe
    }
} // End of Class


