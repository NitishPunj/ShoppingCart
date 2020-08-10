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
    func deleteRowAt(indexPath: IndexPath)
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
    
    func deleteRowAt(indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
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

