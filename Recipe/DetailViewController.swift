//
//  DetailViewController.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var preRecipe:Recipe?
    
    @IBOutlet weak var recipeContent: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = preRecipe?.title
        recipeContent.text = preRecipe?.content
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        recipeContent.textColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
