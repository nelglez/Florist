//
//  DetailViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addToCart: UIBarButtonItem!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productSKULabel: UILabel!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    var floristController: FloristController?
    
    var product: Romance? {
        didSet {
            updateViews()
        }
    }
    
    var quantity = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        quantityTextField.delegate = self
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    //Stop listening for keyboard events.
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){
       
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        //Move view up logic
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height
        } else {
           //Move view back down
            view.frame.origin.y = 0
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        productImageView.contentMode = .scaleAspectFit
        guard let photoUrlString = items.photoUrl else {return}
        let photoUrl = URL(string: photoUrlString)
        productImageView.sd_setImage(with: photoUrl)
        
    }
    
    @IBAction func addToCartBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let quantity = quantityTextField.text, !quantity.isEmpty, let items = product else {
            ProgressHUD.showError("Please provide a quantity")
            return
        }
        
        let newQuantity = Double(quantity)
        
        guard let amountValue = items.price else {return}
        let am = Double(amountValue)!
        let newPrice = am
        
        let finalPrice = newPrice * newQuantity!
        
        self.quantity = Int(quantity) ?? 1
        guard let name = items.name else {return}
        
        //MARK:- Create an Order Object
        
        //This formats the amount into dollars like this 79.00 instead of double 79.0
         let amount = String(format: "%.02f", finalPrice)
    
        floristController?.createOrder(with: name, price: amount, quantity: Int(quantity)!)
        
        //MARK:- Create Alert
        
        let alert = UIAlertController(title: "Success!", message: "Flowers added to your cart.", preferredStyle: .alert)
      
        let submitAction = UIAlertAction(title: "OK", style: .default) { (_) in

            let count = UserDefaults.standard.integer(forKey: "ordersCount")
            let newCount = count + 1
            
           UserDefaults.standard.set(newCount, forKey: "ordersCount")
            
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(submitAction)
    
        present(alert, animated: true)
   
    }
    
}
