//
//  ViewController.swift
//  Recipe
//
//  Created by Zakaria CHAFIK on 08/07/2018.
//  Copyright © 2018 Zakaria CHAFIK. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 70
        tableView.backgroundView = UIImageView(image: UIImage(named: "breads"))
        
        NSUserDefaultManager.prepare()
        initialiseiCloud()
    }
    
    func initialiseiCloud(){
        let fileManager = FileManager.default
        let iCloudURL = fileManager.ubiquityIdentityToken
        if(iCloudURL != nil && Reachability.isConnectedToNetwork()){
            let store = NSUbiquitousKeyValueStore.default
            let notification = NotificationCenter.default
            notification.addObserver(self, selector: #selector(self.updateFromiCloud), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
            store.synchronize()
        }else{
            let message = "iCloud Not reachable"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            let duration: Double = 5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
    }
    
    @objc func updateFromiCloud(notification:Notification){
        iCloudManager.getFromCloud()
        NSUserDefaultManager.synchronize()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        tableView.reloadData()
        navigationController?.navigationBar.alpha = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeManager.size();
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        if(indexPath.item % 2 == 0){
            cell.backgroundColor = UIColor.clear
        }else{
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            cell.textLabel?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        }
        cell.addRecipe(recipe: RecipeManager.getRecipe(id: indexPath.item))
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailView"){
            let cell = sender as! CustomCell
            let detailView = segue.destination as! DetailViewController
            detailView.preRecipe = cell.recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            RecipeManager.RemoveRecipe(id: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            NSUserDefaultManager.synchronize()
            iCloudManager.sendToCloud()
        }
    
    }

}

