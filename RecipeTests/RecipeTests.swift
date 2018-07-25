//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import XCTest
@testable import Recipe

class RecipeTests: XCTestCase {
    
    var storage = UserDefaultsMock() as UserDefaultsProtocol
    
    override func setUp() {
        super.setUp()
        RecipeManager.recipes = [Recipe]()
        RecipeManager.AddRecipe(Recipe(title: "item1", content: "content1"))
        RecipeManager.AddRecipe(Recipe(title: "item2", content: "content2"))
        NSUserDefaultManager.setStorage(storage: storage)
        NSUserDefaultManager.synchronize()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_return_count_1_when_add_recipe() {
        let recipe = Recipe(title: "test1", content: "test2")
        RecipeManager.AddRecipe(recipe)
        XCTAssertEqual(RecipeManager.size(), 3)
    }
    
    func test_should_return_details_when_create_recipe() {
        let recipe = Recipe(title: "test1", content: "test2")
        XCTAssertEqual(recipe.title, "test1")
        XCTAssertEqual(recipe.content, "test2")
    }
    
    func test_return_0_when_delete_recipe(){
        let recipe = Recipe(title: "test1", content: "test2")
        RecipeManager.AddRecipe(recipe)
        RecipeManager.RemoveRecipe(id: 0)
        XCTAssertEqual(RecipeManager.size(), 2)
    }
    
    func test_return_details_when_get_recipe(){
        let recipe = Recipe(title: "test1", content: "test2")
        RecipeManager.AddRecipe(recipe)
        let recipeFromRecipeManager =  RecipeManager.getRecipe(id: 2)
        XCTAssertEqual(recipeFromRecipeManager.title, recipe.title)
        XCTAssertEqual(recipeFromRecipeManager.content, recipe.content)
    }

    func test_should_return_2_without_synchro(){
        let recipe = Recipe(title: "test1", content: "test2")
        RecipeManager.AddRecipe(recipe)
        let defaultUsersRecipes = NSUserDefaultManager.userDefault.theObject(forKey: NSUserDefaultManager.key)
        if let recipes = NSKeyedUnarchiver.unarchiveObject(with: defaultUsersRecipes as! Data) as? [Recipe]{
            XCTAssertEqual(recipes.count, 2)
        }
        
    }
    
    func test_should_return_3_with_synchro(){
        let recipe = Recipe(title: "test1", content: "test2")
        RecipeManager.AddRecipe(recipe)
        NSUserDefaultManager.synchronize()
        let defaultUsersRecipes = NSUserDefaultManager.userDefault.theObject(forKey: NSUserDefaultManager.key)
        if let recipes = NSKeyedUnarchiver.unarchiveObject(with: defaultUsersRecipes as! Data) as? [Recipe]{
            XCTAssertEqual(recipes.count, 3)
        }
        
    }
    
}

class UserDefaultsMock: NSObject, UserDefaultsProtocol {
    private var dict = [String:Any?]()
    
    deinit {
        dict.removeAll()
    }

    func theObject(forKey key: String) -> Any? {
        if let object = dict[key] {
            return object
        }
        return nil
    }
    
    func setTheObject(_ object: Any, forKey key: String) {
        dict[key] = object
    }
    
    func removeTheObject(forKey key: String) {
        dict.removeValue(forKey: key)
    }
    
    func synchronizeAll() {
    }
}
