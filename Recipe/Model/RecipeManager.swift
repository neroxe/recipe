//
//  RecipeManager.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {
    static var recipes = [Recipe]()
    
    static func AddRecipe(title: String,content: String){
        let recipe = Recipe(title: title, content: content)
        recipes.append(recipe)
    }

    static func AddRecipe(_ recipe: Recipe){
        recipes.append(recipe)
    }
    
    static func RemoveRecipe(id: Int){
        recipes.remove(at: id)
    }
    static func size() -> Int{
        return recipes.count
    }
    
    static func getRecipe(id: Int) -> Recipe{
        if(recipes.count>0){
            return recipes[id]
        }
        return Recipe()
    }

}
