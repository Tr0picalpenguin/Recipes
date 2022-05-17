//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Scott Cox on 5/16/22.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeTitleTextField: UITextField!
    @IBOutlet weak var calorieCountTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var recipe: Recipe?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let recipe = recipe else {return}
        let calories = recipe.calories ?? 0
        let cookTime = recipe.cookTime ?? 0
        
        recipeTitleTextField.text = recipe.title
        recipeDescriptionTextView.text = recipe.description
        calorieCountTextField.text = "\(calories)"
        cookTimeTextField.text = "\(cookTime)"
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        guard let recipe = recipe else {return}
        if recipe.isFavorite == true {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let recipe = recipe, let title = recipeTitleTextField.text,
              let description = recipeDescriptionTextView.text else {return}
        
        let calories = Int(calorieCountTextField.text ?? "")
        let cookTime = Int(cookTimeTextField.text ?? "")
        
        RecipeController.sharedInstance.updateRecipe(recipeToUpdate: recipe, newTitle: title, newDescription: description, newCalories: calories, newCookTime: cookTime)
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let recipe = recipe else {return}
        RecipeController.sharedInstance.toggleIsFavorite(recipe: recipe)
        updateFavoriteButton()
    }
} // End of Class
