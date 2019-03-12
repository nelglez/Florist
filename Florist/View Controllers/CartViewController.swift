//
//  CartViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var floristController = FloristController()
    
    var price: [Double] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
   //     tableView.reloadData()
        tableView.tableFooterView = UIView()
      //  updateView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(newDeletion(_:)), name: .deleteItem, object: nil)
       
         NotificationCenter.default.addObserver(self, selector: #selector(newAddition(_:)), name: .addItem, object: nil)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
          updateView()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        price = []
    }
    
    @objc func newDeletion(_ notification: Notification) {
        
        guard let selectedItemPrice = notification.userInfo?["itemPrice"] as? String else {return}
        
        let amountValue = selectedItemPrice
        let am = Double(amountValue)!
        let newPrice = am
        
        if let index = price.firstIndex(of: newPrice) {
            price.remove(at: index)
        }
        
        let total = price.reduce(0, +)
        
        totalLabel.text = "Total: $ \(total)"
        
  
    }
    
    @objc func newAddition(_ notification: Notification) {
        
        guard let selectedItemPrice = notification.userInfo?["itemPriceAdded"] as? String else {return}
        
        let amountValue = selectedItemPrice
        let am = Double(amountValue)
        let newPrice = am
       
      //  price.append(newPrice!)
        
        let total = price.reduce(0, +)

        totalLabel.text = "Total: $ \(total)"
        
        print("NEW PRICE: \(total)")
        
    }
    
    
  
    
    func updateView() {

       let orders = floristController.orders
        

        for i in orders {
            if let amountValue = i.price, let am = Double(amountValue) {
                
              //  let newPrice = am
                price.append(am)
                
               // price += newPrice
                print("******\(am)")
                print("PRICE: \(price)")
            }
        }
        let total = price.reduce(0, +)
        print("TOTAL: \(total)")
        totalLabel.text = "Total: $ \(total)"
        
       
       

    }


}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floristController.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        let orders = floristController.orders[indexPath.row]
        
        cell.orders = orders
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let order = floristController.orders[indexPath.row]
            
            floristController.deleteOrder(order: order)
           
            tableView.deleteRows(at: [indexPath], with: .fade)
          //  updateView()
    }
    
    }
    
}

