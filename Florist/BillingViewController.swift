//
//  BillingViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class BillingViewController: UIViewController {
    
    @IBOutlet weak var billingFullNameTextField: UITextField!
    @IBOutlet weak var billingTelephoneNumberTextField: UITextField!
    @IBOutlet weak var billingEmailTextField: UITextField!
    @IBOutlet weak var billingAddressTextField: UITextField!
    @IBOutlet weak var billingCityTextField: UITextField!
    @IBOutlet weak var billingStatePicker: UIPickerView!
    @IBOutlet weak var billingZipCodeTextField: UITextField!
    @IBOutlet weak var billingCardFullNameTextField: UITextField!
    @IBOutlet weak var billingCreditCardNumberTextField: UITextField!
    @IBOutlet weak var billingCreditCardExpirationDate: UITextField!
    @IBOutlet weak var billingCreditCardCVCNumbersTextField: UITextField!
    @IBOutlet weak var payNowButton: UIButton!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func payNowButtonPressed(_ sender: UIButton) {
    }
    
}
