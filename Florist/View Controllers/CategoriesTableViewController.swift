//
//  CategoriesTableViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var floristController: FloristController?
    var categories: [Categories] = []

    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
       
    }
    
    
    func loadCategories() {
    //    floristController?.loadCategories(completion: {
            self.tableView.reloadData()
    //    })
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
     //   return floristController?.categories.count ?? 0
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath)

     //   let newCategories = floristController?.categories[indexPath.row]
        let newCategories = categories[indexPath.row]
        
        cell.textLabel?.text = newCategories.name
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let category = categories[indexPath.row].id {
        
        let userInfo = ["categoryId": category]
        
        NotificationCenter.default.post(name: .changeCategoryId, object: self, userInfo: userInfo)
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }


}
