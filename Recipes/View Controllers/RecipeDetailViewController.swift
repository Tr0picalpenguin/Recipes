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
} // End of Class
