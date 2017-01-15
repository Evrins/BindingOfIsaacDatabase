//
//  FilterModel.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/6/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class FilterModel: Object, Mappable {
    dynamic var filterName = ""
    dynamic var filterValue = ""
    dynamic var filterType = ""
    dynamic var headerType = ""
    dynamic var active = false
    
    dynamic var filterKey = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "filterKey"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        filterName <- map["filterName"]
        filterValue <- map["filterValue"]
        filterType <- map["filterType"]
        headerType <- map["headerType"]
    }
    
    func toggleActive() {
        active = !active
    }
    
    func getFilterName() -> String {
        return self.filterName
    }
    
    func getFilterValue() -> String {
        return self.filterValue
    }
   
    func getFilterType() -> String {
        return self.filterType
    }
    
    func getHeaderType() -> String {
        return self.headerType
    }
    
    func isActive() -> Bool {
        if active {
            return true
        }
        return false
    }
    
    func getFilterValueArray() -> [String] {
        return self.filterValue.components(separatedBy: ",")
    }

}
