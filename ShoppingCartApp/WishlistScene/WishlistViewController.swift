//
//  WishlistViewController.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

protocol WishlistViewProtocol: class {
    func reloadTable()
}

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: WishlistPresenterProtocol?
    
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


extension WishlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WishlistTableViewCell.reuseIdentifier, for: indexPath) as? WishlistTableViewCell else { fatalError() }
        guard let model = presenter?.objectAtIndexPath(indexPath) else {fatalError("Object not found")}
        cell.updateWithModel(model)
        cell.removeFromWishlist = { [weak self] in
            self?.presenter?.removeItem(atIndexPath: indexPath)
        }
        return cell
    }
}

extension WishlistViewController: WishlistViewProtocol {
    
    func reloadTable() {
        tableView.reloadData()
    }
}

