//
//  Categories.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class Categories {
    var id: String?
    var title: String?
}

extension Categories {
    static func transformCategories(dict: [String:Any], key: String) -> Categories {
        let category = Categories()
        category.id = key
        category.title = dict["title"] as? String
        return category
    }
    
}
