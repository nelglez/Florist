//
//  ProductCollectionViewCell.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var romance: Romance? {
        didSet {
            updateViews()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
  func updateViews() {
    guard let romance = romance else {return}
    productTitleLabel.text = romance.name
    productPriceLabel.text = "$ \(String(describing: romance.price!))"
    guard let photoUrlString = romance.photoUrl else {return}
    let photoUrl = URL(string: photoUrlString)
    productImageView.sd_setImage(with: photoUrl)
    productImageView.contentMode = .scaleAspectFit
    }

    
    
}
