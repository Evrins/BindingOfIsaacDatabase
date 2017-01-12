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

class FilterCollection: NSObject {    
    static let sharedInstance = FilterCollection()
    private override init() {}
    
    var filtersChanged: ((() -> Void))?
    
    var allFilters = [FilterModel]()
    var activeFilters = [FilterModel]()
    
    var activeSubPredicates = [NSPredicate]()
    
    func loadFilterModels() {
        if let url = Bundle.main.url(forResource: "BoI Filters", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                
                let json = JSON(data: jsonData)
                
                for item in json["BoI Filters"].arrayValue {
                    let newItem = FilterModel(JSONString: "\(item)")
                    
                    if newItem?.filterName != "" {
                        allFilters.append(newItem!)
                    }
                }
                
            } catch {
                // Handle Error
                print("There was an issue loading from JSON")
            }
        }
    }
    
    func addMultipleActiveFilter(filters: [FilterModel]?) {
        if filters != nil {
            for filter in filters! {
                self.addActiveFilter(filter: filter)
            }
        }
    }
    
    func addActiveFilter(filter: FilterModel?) {
        if filter != nil && !activeFilters.contains(filter!) {
            activeFilters.append(filter!)
        }
    }
    
    func clearFilters() {
        activeFilters = []
    }
    
    func getAllFilters() -> [FilterModel] {
        return self.allFilters
    }
    
    func getActiveFilters() -> [FilterModel] {
        return self.activeFilters
    }
    
    func getActivePredicates() -> [NSPredicate] {
        activeSubPredicates = []
        
        for filter in self.getActiveFilters() {
            let predicate = NSPredicate(format: "%K contains[C] %@", filter.filterType, filter.filterValue)
            self.activeSubPredicates.append(predicate)
        }
        
        return self.activeSubPredicates
    }
    
}
