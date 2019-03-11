//
//  DetailViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var addToCart: UIBarButtonItem!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productSKULabel: UILabel!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    var product: Romance? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
       
    }
    
    func updateViews() {
        guard isViewLoaded else {
            return
        }
        
        guard let items = product else {return}
        
        productTitleLabel.text = items.name
        productPriceLabel.text = "$ \(String(describing: items.price!))"
        productDescriptionTextView.text = items.description
        productSKULabel.text = items.sku
        
        guard let photoUrlString = items.photoUrl else {return}
        let photoUrl = URL(string: photoUrlString)
        productImageView.sd_setImage(with: photoUrl)
    }
    
    @IBAction func addToCartBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
   

}
