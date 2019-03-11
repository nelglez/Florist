//
//  CategoriesAPI.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class CategoriesAPI {
private var REF_CATEGORIES = Database.database().reference().child("Categories")

func observeCategories(completion: @escaping (Categories) -> Void){
    REF_CATEGORIES.observe(.childAdded) { (snapshot) in
        
        if let dict = snapshot.value as? [String: Any] {
            let newCategory = Categories.transformCategories(dict: dict, key: snapshot.key)
            completion(newCategory)
            
        }
    }
}
}
