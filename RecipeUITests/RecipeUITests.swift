//
//  RecipeUITests.swift
//  RecipeUITests
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import XCTest

class RecipeUITests: XCTestCase {
    
    var app:XCUIApplication? = nil
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app?.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    
    func test_should_show_detailView_after_click_on_cell() {
        addRecipe("testClick")
        let table = app?.tables["mainTable"]
        table?.children(matching: .cell).element(boundBy: 0).staticTexts["testClick"].tap()
        app?.navigationBars["testClick"].buttons["Recipes"].tap()
    }
    
    func test_should_add_recipe_after_fill_in_the_form() {
        let table = app?.tables["mainTable"]
        let tablesSize = table?.cells.count
        app?.navigationBars["Recipes"].buttons["Add"].tap()
        let element = app?.otherElements.containing(.navigationBar, identifier:"Add Recipe").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element?.children(matching: .textField).element
        textField?.tap()
        textField?.typeText("testTextFieldAdd")
        let textView = element?.children(matching: .textView).element
        textView?.tap()
        textView?.typeText("testTextViewAdd")
        app?.navigationBars["Add Recipe"].buttons["Done"].tap()
        app?.buttons["Add"].tap()
        let addRecipeNavigationBar = app?.navigationBars["Add Recipe"]
        addRecipeNavigationBar?.buttons["Recipes"].tap()
        XCTAssertEqual(table?.cells.count, tablesSize!+1)
    }
    
    func test_should_remove_recipe_after_swipe_left() {
        addRecipe("testTextFieldRemove")
        let maintableTable = app?.tables["mainTable"]
        let tablesSize = maintableTable?.cells.count
        if(tablesSize! > 0){
            maintableTable?.staticTexts["testTextFieldRemove"].swipeLeft()
            maintableTable?.buttons["Delete"].tap()
            XCTAssertEqual(maintableTable?.cells.count, tablesSize!-1)
        }
        else{
            XCTAssertEqual(tablesSize, 0)
        }
    }
    
    func addRecipe(_ titleLabel:String) {
        app?.navigationBars["Recipes"].buttons["Add"].tap()
        let element = app?.otherElements.containing(.navigationBar, identifier:"Add Recipe").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element?.children(matching: .textField).element
        textField?.tap()
        textField?.typeText(titleLabel)
        let textView = element?.children(matching: .textView).element
        textView?.tap()
        textView?.typeText(titleLabel)
        app?.navigationBars["Add Recipe"].buttons["Done"].tap()
        app?.buttons["Add"].tap()
        let addRecipeNavigationBar = app?.navigationBars["Add Recipe"]
        addRecipeNavigationBar?.buttons["Recipes"].tap()
    }
    
}

