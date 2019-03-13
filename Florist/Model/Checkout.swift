//
//  Checkout.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Checkout: Codable {
    var total: Double
    var deliveryDate: String
    var cardMessage: String?
    var shippingAddressLine1: String
    var shippingAddressName: String
    var shippingAddressZipcode: String
    var shippingAddressPhoneNumber: String
    var shippingMethodIdentifier: String
}
