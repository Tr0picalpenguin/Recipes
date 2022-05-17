//
//  RecipeCategoryTableViewController.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import UIKit

class RecipeCategoryTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RecipeController.sharedInstance.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = RecipeController.sharedInstance.categories[indexPath.row]
        cell.textLabel?.text = category.title
        cell.detailTextLabel?.text = "\(category.recipes.count) Recipes"
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let categoryToDelete = RecipeController.sharedInstance.categories[indexPath.row]
            RecipeController.sharedInstance.delete(categoryToDelete: categoryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        guard  segue.identifier == "recipeListViewController",
               let destination = segue.destination as? RecipeListTableViewController,
               let indexPath = tableView.indexPathForSelectedRow else {return}
        // Object to send
        let category = RecipeController.sharedInstance.categories[indexPath.row]
        destination.category = category
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        // Create a new category
        RecipeController.sharedInstance.createRecipeCategory()
        // Create the cslls
        tableView.reloadData()
    }
    
}
