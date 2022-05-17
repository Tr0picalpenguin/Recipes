//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Scott Cox on 5/17/22.
//

import UIKit


protocol RecipeTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonWasTapped(cell: RecipeTableViewCell)
}

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties (what properties does the cell need to display?)
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: RecipeTableViewCellDelegate?
    
    // MARK: - Helper Methods
    func updateViews() {
        guard let recipe = recipe else {return}
        
        // What from the recipe am I trying to display?
        recipeTitleLabel.text = recipe.title
        recipeCaloriesLabel.text = "\(recipe.calories ?? 0) Cals"
        
        if recipe.isFavorite == true {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func toggleFavoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonWasTapped(cell: self)
    }
    
} // End of Class
