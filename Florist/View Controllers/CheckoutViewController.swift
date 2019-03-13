//
//  CheckoutViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class CheckoutViewController: UIViewController {
    
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
        
        print("THE DATE FOR DELIVERY IS: \(date)")
        
    }
    
    @IBAction func datePickerPressed(_ sender: UIDatePicker) {
        
        
        sender.minimumDate = Date()
        sender.timeZone = TimeZone.current
       
        self.dateString = dateToString(datePicker: sender)
        
    }
    
}
