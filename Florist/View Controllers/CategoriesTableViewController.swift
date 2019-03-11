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

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
       
    }

    
    func loadCategories() {
        floristController?.loadCategories(completion: {
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return floristController?.categories.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath)

        let newCategories = floristController?.categories[indexPath.row]
        
        cell.textLabel?.text = newCategories?.name
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }


}
