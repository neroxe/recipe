//
//  NSUserDefaultManager.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class NSUserDefaultManager: NSObject {
    static let userDefault = UserDefaults.standard
    
    class func synchronize(){
        let data = NSKeyedArchiver.archivedData(withRootObject: RecipeManager.recipes)
        userDefault.set(data, forKey: "recipe_array")
        userDefault.synchronize()
    }
    class func prepare(){
        if let rawRecipes = userDefault.data(forKey: "recipe_array"){
            if let recipes = NSKeyedUnarchiver.unarchiveObject(with: rawRecipes) as? [Recipe]{
                RecipeManager.recipes = recipes
            }
        }
    }
}
