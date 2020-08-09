//
//  ProductCollectionViewFlowLoayout.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    case list
    case grid(columns: Int)
}

extension CollectionDisplay : Equatable {
    
    public static func == (lhs: CollectionDisplay, rhs: CollectionDisplay) -> Bool {
        switch (lhs, rhs) {
        case (.list, .list):
            return true
        case (.grid(let lColumn), .grid(let rColumn)):
            return lColumn == rColumn
        default:
            return false
        }
    }
}

class ProductCollectionViewFlowLoayout : UICollectionViewFlowLayout {
    
    let cellHeight: CGFloat = 275.0
    var display : CollectionDisplay = .list {
        didSet {
            if display != oldValue {
                invalidateLayout()
            }
        }
    }
    var containerWidth: CGFloat = 0.0 {
        didSet {
            if containerWidth != oldValue {
                invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay, containerWidth: CGFloat) {
        self.init()
        self.display = display
        self.containerWidth = containerWidth
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
        configLayout()
    }
    
    func configLayout() {
        switch display {
        case .grid(let column):
            scrollDirection = .vertical
            let spacing = CGFloat(column - 1) * minimumLineSpacing
            let optimisedWidth = (containerWidth - spacing) / CGFloat(column)
            itemSize = CGSize(width: optimisedWidth , height: cellHeight)
        case .list:
            scrollDirection = .vertical
            let optimisedWidth = (containerWidth - minimumLineSpacing) / CGFloat(2)
            itemSize = CGSize(width: optimisedWidth , height: cellHeight)
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
