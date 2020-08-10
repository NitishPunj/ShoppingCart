//
//  WishlistTableViewCell.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {
    static let reuseIdentifier = "WishlistTableViewCell"
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var removeFromWishlist: (()->Void)?
    
    @IBAction func removePressed(_ sender: Any) {
        removeFromWishlist?()
    }
}

extension WishlistTableViewCell {
    func updateWithModel(_ model: ProductViewModel) {
        nameLabel.text = model.name
        priceLabel.text = model.price
    }
}
