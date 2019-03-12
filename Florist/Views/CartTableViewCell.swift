//
//  CartTableViewCell.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    var orders: Order? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    private func updateViews() {
        guard let order = orders else {return}
        itemTitleLabel.text = order.itemName
        itemPriceLabel.text = "$" + " " + order.price!
        itemQuantityLabel.text = "Qty: \(order.quantity)"
    }

}
