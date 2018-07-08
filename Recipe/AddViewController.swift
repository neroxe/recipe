//
//  AddViewController.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var recipeContent: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addAnimation: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        addButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textContentDidChange), name: Notification.Name.UITextFieldTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textTitleDidChange), name: Notification.Name.UITextViewTextDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textContentDidChange(){
        handleButtonStates()
    }
    @objc func textTitleDidChange(){
        handleButtonStates()
    }
    

    @IBAction func addButton_click(_ sender: Any) {
        recipeContent.resignFirstResponder();
    }
    
    @IBAction func titleDoneButton_click(_ sender: Any) {
        titleText.resignFirstResponder();
    }
    
    @IBAction func addRecipe(_ sender: Any) {
        addAnimation.startAnimating()
        RecipeManager.AddRecipe(title: titleText.text!, content: recipeContent.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addAnimation.stopAnimating()
            self.recipeContent.text = ""
            self.titleText.text = ""
        }
        NSUserDefaultManager.synchronize()
    }
    
    
    func handleButtonStates(){
        if(recipeContent.text != ""){
            doneButton.isEnabled = true
        }
        else{
            doneButton.isEnabled = false
        }
        
        if(titleText.text != "" &&
            recipeContent.text != ""){
            doneButton.isEnabled = true
            addButton.isEnabled = true
            addButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            
        }
        else{
            doneButton.isEnabled = false
            addButton.isEnabled = false
            addButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        }
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
