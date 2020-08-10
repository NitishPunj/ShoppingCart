//
//  Spinner.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class Spinner: NSObject {
    
    private var spinner: UIView?
    
    func show(on view: UIView) {
        guard spinner == nil else { return }
        let spinnerView = UIView(frame: view.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            view.addSubview(spinnerView)
        }
        spinner = spinnerView
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
}
