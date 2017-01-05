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
    
    var onComplete: ((() -> Void))?
    
    static let sharedInstance = ItemCollection()
    private override init() {}
    
    let realm = try! Realm()
    
    var currentItems: Results<ItemModel>!
    var loadedItems: Results<ItemModel>!
    
    func getItems() -> Results<ItemModel>! {
        return self.currentItems
    }
    
    func filterItemsByProperty(property: String, itemAttribute: String) {
        let predicate = NSPredicate(format: "globalType == '\(property.lowercased())'")
        self.currentItems = self.loadedItems.filter(predicate)
        onComplete?()
    }
}

// MARK: - Load Items
extension ItemCollection {
    func loadItems() {
        self.loadedItems = self.realm.objects(ItemModel.self)
        
        if self.loadedItems.isEmpty {
            self.loadInitialItems()
        } else {
            self.currentItems = self.loadedItems
            onComplete?()
        }
    }
    
    func loadItemsWithoutDelegate() {
        self.loadedItems = self.realm.objects(ItemModel.self)
        self.currentItems = self.loadedItems
    }
    
    func loadInitialItems() {
        DataSource.loadItems() { (success) -> Void in
            self.loadedItems = self.realm.objects(ItemModel.self)
            self.currentItems = self.loadedItems
            self.onComplete?()
        }
    }
}
