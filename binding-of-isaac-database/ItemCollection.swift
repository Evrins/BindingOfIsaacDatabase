//
//  ItemCollection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation
import RealmSwift

class ItemCollection: NSObject {
    
    var onComplete: ((_ complete: Bool)->())?
    
    static let sharedInstance = ItemCollection()
    private override init() {}
    
    let realm = try! Realm()
    
    var items: Results<ItemModel>!
    
    func getItems() -> Results<ItemModel>! {
        return self.items
    }
    
    func getItemsSorted(byProperty: String) -> Results<ItemModel>! {
        return self.realm.objects(ItemModel.self).sorted(byProperty: byProperty)
    }
    
    func loadItems() {
        self.items = self.realm.objects(ItemModel.self)
        
        if self.items.isEmpty {
            self.loadInitialItems()
        } else {
            onComplete?(true)
        }
    }
    
    func loadItemsWithoutDelegate() {
        self.items = self.realm.objects(ItemModel.self)
    }
    
    func loadInitialItems() {
        DataSource.loadItems() { (success) -> Void in
            self.items = self.realm.objects(ItemModel.self)
            self.onComplete?(true)
        }
    }
    
}
