//
//  Categories.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class Categories {
    var id: String?
    var name: String?

}

extension Categories {
    static func transformCategories(dict: [String:Any], key: String) -> Categories {
        let category = Categories()
        category.id = key
        category.name = dict["name"] as? String
        return category
    }
    
}
