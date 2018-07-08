//
//  Recipe.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class Recipe: NSObject, NSCoding {
    
    var title: String?
    var content: String?
    
    init(title: String,content: String) {
        self.title = title
        self.content = content
    }
    
    override init() {
        super.init()
        self.title = "empty"
        self.content = "empty"
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let titleDecoded = aDecoder.decodeObject(forKey: "title") as? String{
            title = titleDecoded
        }
        if let contentDecoded = aDecoder.decodeObject(forKey: "content") as? String{
            content = contentDecoded
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let titleEncoded = title {
            aCoder.encode(titleEncoded,forKey: "title")
        }
        if let contentEncoded = content {
            aCoder.encode(contentEncoded,forKey: "content")
        }
    }
}
