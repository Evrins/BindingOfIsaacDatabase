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
    
    let filterCollection = FilterCollection.sharedInstance
    
    var onComplete: ((() -> Void))?
    
    static let sharedInstance = ItemCollection()
    private override init() {}
    
    let realm = try! Realm()
    
    var currentItems: Results<ItemModel>!
    var loadedItems: Results<ItemModel>!
    
    func getItems() -> Results<ItemModel>! {
        return self.currentItems
    }
    
    func setCurrentItemsToLoadedItems() {
        self.currentItems = self.loadedItems
        onComplete?()
    }
}

// MARK: - Filtering Item
extension ItemCollection {
    func filterGlobalType(by: String) {

        let predicate = NSPredicate(format: "\(Filters.ItemAttribute.GlobalType) == '\(by)'")
        
        self.currentItems = self.loadedItems.filter(predicate)
        
        if by == "items" {
            self.filterItemsByActiveFilters()
        }
        
        onComplete?()
    }
    
    
    func filterItemsByActiveFilters() {
        let subPredicates = filterCollection.activeSubPredicates
        
        if !subPredicates.isEmpty {
            let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: subPredicates)
            
            currentItems = currentItems.filter(compoundPredicate)
        }
        
    }
}

// MARK: - Load Items
extension ItemCollection {
    func loadItems() {
        self.loadedItems = self.realm.objects(ItemModel.self)
        
        if self.loadedItems.isEmpty {
            self.loadInitialItems()
        } else {
            self.setCurrentItemsToLoadedItems()
        }
    }
    
    func loadItemsWithoutDelegate() {
        self.loadedItems = self.realm.objects(ItemModel.self)
        self.currentItems = self.loadedItems
    }
    
    func loadInitialItems() {
        DataSource.loadItems() { (success) -> Void in
            self.loadedItems = self.realm.objects(ItemModel.self)
            self.setCurrentItemsToLoadedItems()
        }
    }
}
