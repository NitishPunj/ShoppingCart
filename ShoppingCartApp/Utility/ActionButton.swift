//
//  ActionButton.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit
class ActionButton: UIButton {

    override public var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = backgroundColor?.withAlphaComponent(1.0)
            } else {
                backgroundColor = backgroundColor?.withAlphaComponent(0.1)
            }
        }
    }

}
