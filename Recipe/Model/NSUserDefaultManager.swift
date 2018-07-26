//
//  NSUserDefaultManager.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

public class NSUserDefaultManager: NSObject {
    static var userDefault:UserDefaultsProtocol = UserDefaults.standard
    static var key:String = "recipe_array"
    
    class func synchronize(){
        let data = NSKeyedArchiver.archivedData(withRootObject: RecipeManager.recipes)
        userDefault.setTheObject(data, forKey: key)
        userDefault.synchronizeAll()
    }
    
    class func setStorage(storage:UserDefaultsProtocol){
        NSUserDefaultManager.userDefault = storage;
    }
    
    class func prepare(){
        if let rawRecipes = userDefault.theObject(forKey: key){
            if let recipes = NSKeyedUnarchiver.unarchiveObject(with: rawRecipes as! Data) as? [Recipe]{
                RecipeManager.recipes = recipes
            }
        }
    }
}
extension UserDefaults:UserDefaultsProtocol{
    func theObject(forKey key: String) -> Any? {
        return self.data(forKey:key)
    }
    
    func setTheObject(_ object: Any, forKey key: String) {
        self.set(object, forKey: key)
    }
    
    func removeTheObject(forKey key: String) {
        self.removeObject(forKey: key)
    }
    
    func synchronizeAll() {
        self.synchronize()
    }
}

protocol UserDefaultsProtocol {
    func theObject(forKey key:String) -> Any?
    func setTheObject(_ object:Any, forKey key:String)
    func removeTheObject(forKey key:String)
    func synchronizeAll()
}
