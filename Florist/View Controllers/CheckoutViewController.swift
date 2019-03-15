//
//  CheckoutViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD
import Stripe

class CheckoutViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cardMessageTextView: UITextView!
    
    
    var dateString: String?
    
    var total: Double?
    

    let checkoutController = CheckoutController()
    var floristController = FloristController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardMessageTextView.delegate = self
        cardMessageTextView.text = "Write your card message here ..."
       
        self.datePicker.minimumDate = Date()
        self.datePicker.timeZone = TimeZone.current
     
        self.dateString = dateToString(datePicker: self.datePicker)
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if cardMessageTextView.text == "Write your card message here ..." {
            cardMessageTextView.text = nil
            cardMessageTextView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if cardMessageTextView.text == nil {
            cardMessageTextView.text = "Write your card message here ..."
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            cardMessageTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func dateToString(datePicker: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.datePicker.date)
    }
    

    @IBAction func selectShippingBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard dateString != nil else {
            ProgressHUD.showError("Please select a delivery date")
            return
        }
        
        handleShippingButtonTapped()
        
    }
    
    @IBAction func datePickerPressed(_ sender: UIDatePicker) {
        
        
        sender.minimumDate = Date()
        sender.timeZone = TimeZone.current
       
        self.dateString = dateToString(datePicker: sender)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ReviewViewController
        let checkout = checkoutController.checkout.first
       
        destinationVC?.checkout = checkout
        destinationVC?.floristController = floristController
    }
    
    
}

extension CheckoutViewController: STPShippingAddressViewControllerDelegate {
    
    func handleShippingButtonTapped() {
        STPPaymentConfiguration.shared().requiredShippingAddressFields = [.postalAddress, .phoneNumber, .emailAddress, .name]
        // Setup shipping address view controller
        let shippingAddressViewController = STPShippingAddressViewController()
        shippingAddressViewController.delegate = self as STPShippingAddressViewControllerDelegate
        
        // Present shipping address view controller
        let navigationController = UINavigationController(rootViewController: shippingAddressViewController)
        present(navigationController, animated: true)
    }
    
    
    func shippingAddressViewControllerDidCancel(_ addressViewController: STPShippingAddressViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func shippingAddressViewController(_ addressViewController: STPShippingAddressViewController, didEnter address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        
        print("didEnterAddress")
        print(address)
        
        
        let handDelivered = PKShippingMethod()
        handDelivered.amount = 10.00
        handDelivered.label = "Hand Delivered"
        handDelivered.detail = "Arrives today before the day is over"
        handDelivered.identifier = "hand_delivered"
        
        let pickup = PKShippingMethod()
        pickup.amount = 0.00
        pickup.label = "Pickup at the store"
        pickup.detail = "Picked up before 5"
        pickup.identifier = "pickup"
        
       
        
        if address.country == "US" {
            let availableShippingMethods = [handDelivered, pickup]
            let selectedShippingMethod = handDelivered
            
            completion(.valid, nil, availableShippingMethods, selectedShippingMethod)
        }
        else {
            completion(.invalid, nil, nil, nil)
        }
    }
    
    func shippingAddressViewController(_ addressViewController: STPShippingAddressViewController, didFinishWith address: STPAddress, shippingMethod method: PKShippingMethod?) {
        print("didFinishWith")
        // Save selected address and shipping method
       let cost = method?.amount
        
        let method = method?.identifier
        
        
        guard let total = total, let dateString = dateString, let cardMessage = cardMessageTextView.text else {return}
        
        let newtotal = total + Double(truncating: cost ?? 0.0)
        
        checkoutController.checkout(with: newtotal, deliverDate: dateString, cardMessage: cardMessage, shippingAddressLine1: address.line1!, shippingAddressName: address.name!, shippingAddressZipcode: address.postalCode!, shippingAddressPhoneNumber: address.phone!, shippingMethodIdentifier: method!)
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "toCheckoutVC", sender: self)
        }
        
    }
    
    
    
}
