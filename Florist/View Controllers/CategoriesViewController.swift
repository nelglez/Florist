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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRomance()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    func loadRomance(){
        
        floristController.loadRomance(categoryId: self.categoryId) { (romance) in
            self.categoryButton.setTitle("\(String(describing: romance!.name!)) >", for: .normal)
            self.collectionView.reloadData()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoriesVC" {
            let destinationVC = segue.destination as? CategoriesTableViewController
            destinationVC?.floristController = floristController
        } else if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? DetailViewController
             guard let cell = sender as? ProductCollectionViewCell else {return}
            guard let indexPath = collectionView.indexPath(for: cell) else {return}
           // let product = romance[indexPath.item]
            let product = floristController.romance[indexPath.item]
            destinationVC?.product = product
        }
    }

}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return floristController.romance.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let romanceArray = floristController.romance[indexPath.row]
        
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
