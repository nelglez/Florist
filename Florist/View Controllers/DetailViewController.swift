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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func addToCartBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
   

}
