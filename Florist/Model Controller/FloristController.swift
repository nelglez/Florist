//
//  FloristController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FloristController {
   
    private(set) var romance: [Romance] = []
    private(set) var categories: [Categories] = []
    
    func loadRomance(categoryId: String, completion: @escaping(Romance?) -> Void){
        
        API.Romance_ListApi.REF_ROMANCE_LISTS.child(categoryId).observe(.childAdded) { (snapshot) in
            print(snapshot.key)
            
            API.RomanceAPI.observeRomance(withCategoryId: snapshot.key, completion: { (romance) in
                print(snapshot.key)
             //   self.romance.removeAll()//this makes it so that when i come back it doesnt create another value
                self.romance.append(romance)
                completion(romance)
            })
            
        }
    }

    func loadCategories(completion: @escaping(Categories?) -> Void) {
        API.Categories.observeCategories(completion: { (categories) in
            self.categories.removeAll()
            self.categories.append(categories)
            completion(categories)
        })
    }
    
}
