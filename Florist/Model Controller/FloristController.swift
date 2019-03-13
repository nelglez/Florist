//
//  FloristController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreData

class FloristController {
   
    private(set) var romance: [Romance] = []
    private(set) var categories: [Categories] = []
    
    var orders: [Order] {
        
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        return (try? CoreDataStack.shared.mainContext.fetch(request)) ?? []
    }
    
    
    func createOrder(with itemName: String, price: String, quantity: Int) {
      let order = Order(name: itemName, price: price, quantity: quantity)
        //Added
        if let item = order.price {
            
            let userInfo = ["itemPriceAdded": item]
            
            NotificationCenter.default.post(name: .addItem, object: self, userInfo: userInfo)
            //^
            
        }
        
        saveToPersistentStorage()
        
    }
    
    func saveToPersistentStorage(){
        //Save changes to disk
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()//Save the task to the persistent store
        } catch {
            print("Error saving MOC (managed object context): \(error)")
        }
    }
    
    func deleteOrder(order: Order) {
        
        //Added
        if let item = order.price {
            
            let userInfo = ["itemPrice": item]
            
            NotificationCenter.default.post(name: .deleteItem, object: self, userInfo: userInfo)
            //^
            
        }
        let moc = CoreDataStack.shared.mainContext
        
        moc.delete(order)
        
        saveToPersistentStorage()
    }
    
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
