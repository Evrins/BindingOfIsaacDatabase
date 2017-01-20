//
//  FilterCollection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/11/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation
import SwifterSwift
import ObjectMapper
import SwiftyJSON
import RealmSwift

class FilterCollection: NSObject {
    static let sharedInstance = FilterCollection()
    private override init() {}
    
    let realm = try! Realm()
    
    var filtersChanged: ((() -> Void))?
    
    var allFilters: Results<FilterModel>!
    
    var activeSubPredicates = [NSPredicate]()
    
    func loadFilterModels(_ completionHandler:@escaping (Bool) -> ()) {
        guard realm.objects(FilterModel.self).isEmpty else {
            completionHandler(false)
            self.setAllFilters()
            self.setDefaultActiveItems()
            return
        }
        
        if let url = Bundle.main.url(forResource: "BoI Filters", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                
                let json = JSON(data: jsonData)
                
                for item in json["BoI Filters"].arrayValue {
                    let newItem = FilterModel(JSONString: "\(item)")
                    
                    if newItem?.filterName != "" {
                        try! realm.write {
                            realm.add(newItem!)
                        }
                    }
                }
                completionHandler(true)
            } catch {
                // Handle Error
                print("There was an issue loading from JSON")
                completionHandler(false)
            }
        }
        
        self.setAllFilters()
        self.setDefaultActiveItems()
    }
    
    func setAllFilters() {
        allFilters = realm.objects(FilterModel.self)
    }
    
    func setDefaultActiveItems() {
        clearFilters()
        for filter in allFilters {
            if filter.filterName == "All" {
                setActiveFilter(filter: filter)
            }
        }
    }
    
    func addMultipleActiveFilter(filters: [FilterModel]?) {
        if filters != nil {
            for filter in filters! {
                self.setActiveFilter(filter: filter)
            }
        }
    }
    
    func setActiveFilter(filter: FilterModel?) {
        if filter != nil {
            let filtersToSet = allFilters.filter({$0.filterName == filter?.filterName})
            for filter in filtersToSet {
                try! realm.write {
                    filter.active = true
                }
            }
        }
    }
    
    func clearFilters() {
        for filter in allFilters {
            if filter.filterName != "All" {
                try! realm.write {
                    filter.active = false
                }
            }
        }
    }
    
    func getAllFilters() -> Results<FilterModel> {
        return self.allFilters
    }
    
    func getActiveFilters() -> Results<FilterModel> {
        let activeFilters = allFilters.filter("active = true")
        
        return activeFilters
    }
    
    func getActivePredicates() -> [NSPredicate] {

        activeSubPredicates = [NSPredicate]()
        
        for filter in self.getActiveFilters() {
            
            
            var predicate = NSPredicate(format: "%K IN %@", filter.getFilterType(), filter.getFilterValueArray())
            
            if filter.headerType == "Item Pool" {
                // @TODO: Change ANY to ALL and make that work <.<
                predicate = NSPredicate(format: "ANY itemPool.value IN %@", filter.getFilterValueArray())
            }
            self.activeSubPredicates.append(predicate)
            
            // If filterType == ALL remove predicate
            if filter.filterName == "All" {
                self.activeSubPredicates.removeLast()
            }
        }
        
        return self.activeSubPredicates
    }
    
}
