//
//  Romance.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class Romance {
    var name: String?
    var photoUrl: String?
    var description: String?
    var price: String?
    var sku: String?
    var id: String?
}

extension Romance {
    static func transformRomance(dict: [String:Any], key: String) -> Romance {
        let romance = Romance()
        romance.id = key
        romance.name = dict["name"] as? String
        romance.photoUrl = dict["photoUrl"] as? String
        romance.description = dict["description"] as? String
        romance.price = dict["price"] as? String
        romance.sku = dict["sku"] as? String

        return romance
    }
    
}
