//
//  CartItemTableViewCell.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CartItemTableViewCell"
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var removeItem: (()->Void)?
    
    @IBAction func removePressed() {
        removeItem?()
    }
}
extension CartItemTableViewCell {
    func updateWithModel(_ model: CartItemViewModel) {
        nameLabel.text = model.nameLabel
        priceLabel.text = model.priceLabel
    }
}

