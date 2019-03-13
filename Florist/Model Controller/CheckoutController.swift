//
//  CheckoutController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class CheckoutController {
    
    private(set) var checkout: [Checkout] = []
    
    func checkout(with total: Double, deliverDate: String, cardMessage: String? = "", shippingAddressLine1: String, shippingAddressName: String, shippingAddressZipcode: String, shippingAddressPhoneNumber: String, shippingMethodIdentifier: String){
        
        let checkout = Checkout(total: total, deliveryDate: deliverDate, cardMessage: cardMessage, shippingAddressLine1: shippingAddressLine1, shippingAddressName: shippingAddressName, shippingAddressZipcode: shippingAddressZipcode, shippingAddressPhoneNumber: shippingAddressPhoneNumber, shippingMethodIdentifier: shippingMethodIdentifier)
        
        self.checkout.append(checkout)
    }
    
    
}
