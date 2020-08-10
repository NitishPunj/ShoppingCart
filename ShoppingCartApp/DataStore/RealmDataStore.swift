
//
//  RealmDataStore.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataStore {
    
    private var database: Realm
    static let shared = RealmDataStore()
    
    private init() {
        database = try! Realm()
    }
    
    func getAllFromDB() -> Results<ProductItem> {
        let results: Results<ProductItem> = database.objects(ProductItem.self)
        return results
    }
    
    func addData(object: ProductItem) {
        try! database.write {
            database.add(object, update: .modified)
            print("Added new object")
        }
    }
    
    func removeData(productId: Int) {
        guard let object = database.object(ofType: ProductItem.self, forPrimaryKey: productId) else { return }
        try! database.write {
            database.delete(object)
            print("object removed")
        }
    }
    
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
}
extension RealmDataStore: DataStoreProtocol {
    
    func addToWishlist(_ product: ProductViewModel) {
        let item = ProductItem()
        item.name = product.name
        item.id = product.id
        item.price = product.price
        addData(object: item)
    }
    
    func fetchWishlist() -> [ProductViewModel] {
        return  Array(getAllFromDB())
    }
    
    func removeFromWishlist(_ product: ProductViewModel) {
        removeData(productId: product.id)
    }
    
    func fetchAllProducts() -> [ProductViewModel] {
        return  Array(getAllFromDB())
    }
    
    func deleteAll() {
        deleteAllDatabase()
    }
}

final class ProductItem: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var price: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension ProductItem: ProductViewModel {}






