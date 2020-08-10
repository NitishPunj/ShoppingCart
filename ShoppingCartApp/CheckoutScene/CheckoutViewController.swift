//
//  CheckoutViewController.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

protocol CheckoutViewProtocol: class {
    func showLoading()
    func hideLoading()
    func presentError(_ error: Error)
    func updateViewState(_ state: ProductsViewState)
}

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let spinner = Spinner()
    var presenter: CheckoutPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.reuseIdentifier, for: indexPath) as? CartItemTableViewCell else { fatalError() }
        guard let model = presenter?.objectAtIndexPath(indexPath) else {fatalError("Object not found")}
        cell.updateWithModel(model)
        cell.removeItem = { [weak self] in
            self?.presenter?.removeItem(atIndexPath: indexPath)
        }
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        return cell
    }
}

extension CheckoutViewController: CheckoutViewProtocol {
    
    func showLoading() {
        spinner.show(on: tableView)
    }
    
    func hideLoading() {
        spinner.hide()
    }
    
    func presentError(_ error: Error) {
        showErrorAlert(title: error.localizedDescription)
    }
    
    func updateViewState(_ state: ProductsViewState) {
        switch state {
        case .noData:
            tableView.isHidden = true
            totalPriceLabel.text = ""
        case .reload:
            tableView.isHidden = false
            tableView.reloadData()
            totalPriceLabel.text = presenter?.totalPrice
        }
    }
}

