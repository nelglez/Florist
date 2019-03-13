//
//  StripeController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class StripeController {
    
    func sendToBackend(token: STPToken, amount: String, description: String, shipping: String, email: String, completion: @escaping(Error?)->Void) {
        
        let requestString = "https://www.flowerdeliverymiami.net/payment.php"
        let params = ["stripeToken": token.tokenId, "amount": amount, "currency": "usd", "description": description, "shipping": shipping, "email": email] as [String : Any]
        
        Alamofire.request(requestString, method: .post, parameters: params).responseString { response in
            
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
}
