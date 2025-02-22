//
//  ProductsViewController.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

enum ProductsViewState {
    case noData, reload
}

protocol ProductListViewProtocol: class {
    func showLoading()
    func hideLoading()
    func presentError(_ error: APIError)
    func updateViewState(_ state: ProductsViewState)
}

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let spinner = Spinner()
    var presenter: ProductListPresenterProtocol?
    
    lazy var collectionViewFlowLayout : ProductCollectionViewFlowLoayout = {
        let layout = ProductCollectionViewFlowLoayout(display: .list, containerWidth: view.bounds.width)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = collectionViewFlowLayout
        presenter?.viewIsReady()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: .cartUpdated, object: nil)
    }
    
    @objc func refreshList() {
        presenter?.viewIsReady()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        reloadCollectionViewLayout(view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
        collectionViewFlowLayout.containerWidth = width
        collectionViewFlowLayout.display = view.traitCollection.horizontalSizeClass == .compact && view.traitCollection.verticalSizeClass == .regular ? .list : .grid(columns: 4)
    }
    
    @IBAction func wishlistPressed(_ sender: Any) {
        presenter?.wishListPressed()
    }
    @IBAction func basketPressed(_ sender: Any) {
        presenter?.basketPressed()
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else { fatalError() }
        guard let model = presenter?.itemAtIndexPath(indexPath) else {fatalError("Product not found")}
        cell.updateWithModel(model)
        cell.addToCartPressed = { [weak self] in
            self?.presenter?.addToCartPressedForItem(atIndexPath: indexPath)
        }
        cell.addToWishlistPressed = { [weak self] in
            self?.presenter?.addToWishlistPressedForItem(atIndexPath: indexPath)
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

extension ProductsViewController: ProductListViewProtocol {
    
    func showLoading() {
        spinner.show(on: collectionView)
    }
    
    func hideLoading() {
        spinner.hide()
    }
    
    func presentError(_ error: APIError) {
        showErrorAlert(title: error.errorMessage)
    }
    
    func updateViewState(_ state: ProductsViewState) {
        switch state {
        case .noData:
            collectionView.isHidden = true
        case .reload:
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
}


extension Notification.Name {
    static let cartUpdated = Notification.Name("CartUpdated")
}
