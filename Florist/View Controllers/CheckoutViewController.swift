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

class CheckoutViewController: UIViewController{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cardMessageTextView: UITextView!
    
    
    var dateString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.datePicker.minimumDate = Date()
        self.datePicker.timeZone = TimeZone.current
     
        self.dateString = dateToString(datePicker: self.datePicker)
        

    }
    
    func dateToString(datePicker: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.datePicker.date)
    }
    

    @IBAction func selectShippingBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let date = dateString else {
            ProgressHUD.showError("Please select a delivery date")
            return
        }
        
        handleShippingButtonTapped()
        
        print("THE DATE FOR DELIVERY IS: \(date)")
        
    }
    
    @IBAction func datePickerPressed(_ sender: UIDatePicker) {
        
        
        sender.minimumDate = Date()
        sender.timeZone = TimeZone.current
       
        self.dateString = dateToString(datePicker: sender)
        
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
        
//        selectedAddress = address.line1!
//        selectedShippingMethod = method!
        
        
        debugPrint(address.line1! as Any)
        debugPrint(method as Any)
        
        // Dismiss shipping address view controller
        dismiss(animated: true)
    }
    
    
    
}
