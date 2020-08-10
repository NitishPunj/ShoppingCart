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
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var wishlistButton: UIButton!
    
    var addToCartPressed: (()->Void)?
    
    @IBAction func addPressed() {
        addToCartPressed?()
    }
    
    @IBAction func wishlistPressed() {
        //TODO:
        
    }
    
    override func prepareForReuse() {
        addToCartButton.isEnabled = false
        nameLabel.text = ""
        priceLabel.text = ""
        beforePriceLabel.text = ""
        wishlistButton.isSelected = false
    }
}

extension ProductCollectionViewCell {
    func updateWithModel(_ model: Product) {
        nameLabel.text = model.name
        priceLabel.text = model.price
        beforePriceLabel.isHidden = model.isOnSale == false
        beforePriceLabel.text = "was " + (model.oldPrice ?? "")
        model.outOfStock ? (addToCartButton.isEnabled = false) : (addToCartButton.isEnabled = true)
    }
}



