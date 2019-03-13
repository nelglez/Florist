//
//  ViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    
    var floristController = FloristController()
    
    var categoryId = "jgkdflsdjvsdjfvsfk"
    
    var categories: [Categories] = []
    var romance: [Romance] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRomance()
        loadCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
        
         NotificationCenter.default.addObserver(self, selector: #selector(newCategoryAdded(_:)), name: .changeCategoryId, object: nil)
        
        UserDefaults.standard.set(floristController.orders.count, forKey: "ordersCount")
        
        print("CATEGORY ID: \(categoryId)")
        
         NotificationCenter.default.addObserver(self, selector: #selector(badgeCount(_:)), name: .itemCount, object: nil)
        
        setBadge()
        
    }
    
    
    
    func setBadge() {
        let count = UserDefaults.standard.integer(forKey: "ordersCount")
        if count == 0 {
            if let tabItems = self.tabBarController?.tabBar.items {
                let tabItem = tabItems[1]
                
                tabItem.badgeValue = nil
            }
        } else {
            if let tabItems = self.tabBarController?.tabBar.items {
                let tabItem = tabItems[1]
                
                tabItem.badgeValue = String(count)
            }
        }
    }
    
    @objc func badgeCount(_ notification: Notification) {
        print("NOTIFICATION TRIGGERED!")
        guard let badgeCount = notification.userInfo?["itemCount"] as? Int else {return}
        if let tabItems = self.tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            
            tabItem.badgeValue = String(badgeCount)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
        setBadge()
    }
    

@objc func newCategoryAdded(_ notification: Notification) {
    
    guard let categoryIdSelected = notification.userInfo?["categoryId"] as? String else {return}
    
    print("Category Selected \(categoryIdSelected)")
    self.categoryId = categoryIdSelected
   
    self.romance.removeAll()
   loadRomance(Id: categoryIdSelected)
    
    
    }
    
    func loadRomance(Id: String) {
        floristController.loadRomance(categoryId: Id) { (romance) in
            self.categoryButton.setTitle("\(String(describing: romance!.category!)) >", for: .normal)
            guard let romance = romance else {return}
            
            self.romance.append(romance)
            self.collectionView.reloadData()
        }
    }
    
    func loadRomance(){
        
        floristController.loadRomance(categoryId: self.categoryId) { (romance) in
           self.categoryButton.setTitle("\(String(describing: romance!.category!)) >", for: .normal)
            guard let romance = romance else {return}
            self.romance.append(romance)
            self.collectionView.reloadData()
        }
    }
    
    func loadCategories() {
       
        floristController.loadCategories { (categories) in
            guard let categories = categories else {return}
           self.categories.append(categories)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoriesVC" {
            let destinationVC = segue.destination as? CategoriesTableViewController
            destinationVC?.floristController = floristController
            destinationVC?.categories = categories
        } else if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? DetailViewController
             guard let cell = sender as? ProductCollectionViewCell else {return}
            guard let indexPath = collectionView.indexPath(for: cell) else {return}
           // let product = romance[indexPath.item]
            let product = romance[indexPath.item]
            destinationVC?.product = product
            destinationVC?.floristController = floristController
        }
    }

}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return romance.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let romanceArray = romance[indexPath.row]
        cell.layer.borderWidth = 1
        cell.romance = romanceArray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 1, height: collectionView.frame.size.width / 2 - 1)
    }
}
