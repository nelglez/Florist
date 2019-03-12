//
//  Order+Convenience.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

extension Order {
    
    convenience init(name: String, price: String, quantity: Int, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.itemName = name
        self.price = price
        self.quantity = Int16(quantity)
    }
    
}
