//
//  iCloudManager.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 26/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class iCloudManager: NSObject {

    class func getFromCloud(){
        let iCloudStore = NSUbiquitousKeyValueStore.default
        let fromCloud = iCloudStore.object(forKey: NSUserDefaultManager.key)
        if let recipes = NSKeyedUnarchiver.unarchiveObject(with: fromCloud as! Data) as? [Recipe]{
            RecipeManager.recipes = recipes
        }
    }
    class func sendToCloud(){
        let iCloudStore = NSUbiquitousKeyValueStore.default
        let data = NSKeyedArchiver.archivedData(withRootObject: RecipeManager.recipes)
        iCloudStore.set(data, forKey: NSUserDefaultManager.key)
        iCloudStore.synchronize()
    }
}
