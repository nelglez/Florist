//
//  ReviewViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import Stripe
import ProgressHUD
import CoreData

class ReviewViewController: UIViewController, STPAddCardViewControllerDelegate {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var cardMessageTextView: UITextView!
    @IBOutlet weak var shippingAddressTextView: UITextView!
    @IBOutlet weak var payButton: UIButton!
    
    var checkout: Checkout? {
        didSet {
            updateView()
        }
    }
    
    var stripeController = StripeController()
    var floristController: FloristController?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
       
    }
    
    func updateView() {
        
        guard isViewLoaded else {return}
        
        guard let checkout = checkout else {return}
        
        totalLabel.text = "Total: $\(String(format: "%.02f", checkout.total))"
        deliveryDateLabel.text = "Delivery Date: \(checkout.deliveryDate)"
        cardMessageTextView.text = "Card Message: \(checkout.cardMessage!)"
        shippingAddressTextView.text = "Delivery Info: \(checkout.shippingAddressName)," + " " + "Shipping Method:  \(checkout.shippingMethodIdentifier)," + " " + "Phone Number: \(checkout.shippingAddressPhoneNumber)," + " " + "Address: \(checkout.shippingAddressLine1)," + " " + "Zipcode: \(checkout.shippingAddressZipcode)"
        
        payButton.layer.backgroundColor = UIColor.red.cgColor
        payButton.layer.cornerRadius = 10
   
    }
    

    @IBAction func payButtonPressed(_ sender: UIButton) {
        let paymentConfig = STPPaymentConfiguration.init()
        paymentConfig.publishableKey = "pk_test_qbjx68qwygLRCgKsjmiYKQ5d"
        paymentConfig.requiredBillingAddressFields = STPBillingAddressFields.full
        
        let theme = STPTheme.default()
        // Setup add card view controller
        let addCardViewController = STPAddCardViewController(configuration: paymentConfig, theme: theme)
        addCardViewController.delegate = self
        
        // Present add card view controller
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
        
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
     
        self.postStripeToken(token: token) { (error) in
            
            if let error = error {
                ProgressHUD.showError(error.localizedDescription)
            }
            
        }
        

        dismiss(animated: true) {
            
            let alert = UIAlertController(title: "Success!", message: "The payment was successful. :)", preferredStyle: .alert)
            
            let submitAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.floristController?.removeAll()
                
                                UserDefaults.standard.set(nil, forKey: "ordersCount")
                
                            let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as UIViewController
                            self.present(viewController, animated: true, completion: nil)
               
            }
            
            alert.addAction(submitAction)
            
            self.present(alert, animated: true)

        }
       
    }
    
   
    func postStripeToken(token: STPToken, completion: @escaping(Error?)->Void) {
        guard let amount = checkout?.total, let description = checkout?.cardMessage, let shipping = checkout?.shippingAddressLine1, let email = checkout?.shippingAddressPhoneNumber else {return}
        
        stripeController.sendToBackend(token: token, amount: String(format: "%.02f", amount), description: description, shipping: shipping, email: email) { (error) in
            if let error = error {
                print(error.localizedDescription)
                ProgressHUD.showError(error.localizedDescription)
               
            }
 
        }
        
    }
}
