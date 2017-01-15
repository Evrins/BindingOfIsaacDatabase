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
    let menuItemCollection = MenuItemCollection.sharedInstance
    
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
    func filterByAllFilters() {
        let menuAttribute = menuItemCollection.getActive()?.type
        let predicate = NSPredicate(format: "\(Filters.ItemAttribute.GlobalType) == '\(menuAttribute!)'")

        currentItems = loadedItems.filter(predicate)
        
        if menuAttribute == "items" {
            self.filterItemsByActiveFilters()
            return
        }
        
        onComplete?()
    }
    
    
    func filterItemsByActiveFilters() {
        let subPredicates = filterCollection.getActivePredicates()
        
        if !subPredicates.isEmpty {
        
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: subPredicates)
            
            currentItems = currentItems.filter(compoundPredicate)
            
        }
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
