//
//  ItemCollection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation
import RealmSwift

protocol ItemCollectionDelegate {
    func itemsDidFinishLoading()
}

class ItemCollection {
    static let sharedInstance = ItemCollection()
    
    let realm = try! Realm()
    
    var delegate: ItemCollectionDelegate! = nil
    var items: Results<ItemModel>!
    
    
    func getItems() -> Results<ItemModel>! {
        return self.items
    }
    
    func loadItems() {
        self.items = self.realm.objects(ItemModel.self)
        
        if self.items.isEmpty {
            self.loadInitialItems()
        } else {
            self.itemsDidFinish()
        }
    }
    
    func loadItemsWithoutDelegate() {
        self.items = self.realm.objects(ItemModel.self)
    }
    
    func loadInitialItems() {
        DataSource.loadItems() { (success) -> Void in
            self.items = self.realm.objects(ItemModel.self)
            self.itemsDidFinish()
        }
    }
    
    func itemsDidFinish() {
        self.delegate.itemsDidFinishLoading()
    }
}
