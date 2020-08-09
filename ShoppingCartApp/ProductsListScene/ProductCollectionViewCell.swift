//
//  ProductCollectionViewCell.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var beforePriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}

extension ProductCollectionViewCell {
    func updateFromModel(_ model: Product) {
        nameLabel.text = model.name
        priceLabel.text = model.price
        beforePriceLabel.isHidden = model.isOnSale == false
        beforePriceLabel.text = "was " + (model.oldPrice ?? "")
    }
}


