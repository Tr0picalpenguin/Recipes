//
//  RecipeListTableViewController.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryTitletextField: UITextField!
    
    // MARK: - Properties
    var category: RecipeCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let category = category, let newTitle = categoryTitletextField.text else {return}
        
        RecipeController.sharedInstance.updateRecipeCategory(categoryToUpdate: category, title: newTitle)
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category?.recipes.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
        
        guard let category = category else {return cell}
        let recipe = category.recipes[indexPath.row]
        cell.recipe = recipe
        // SET THE GOD DAMN DELEGATE!
        cell.delegate = self
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
    
    // MARK: - Actions
    @IBAction func addRecipeButtonTapped(_ sender: Any) {
        guard let category = category else {return}
        RecipeController.sharedInstance.createRecipe(in: category)
        tableView.reloadData()
        
    }
    
} // End of Class

extension RecipeListTableViewController: RecipeTableViewCellDelegate {
    func toggleFavoriteButtonWasTapped(cell: RecipeTableViewCell) {
        guard let recipe = cell.recipe else {return}
        RecipeController.sharedInstance.toggleIsFavorite(recipe: recipe)
        cell.updateViews()
    }
}

