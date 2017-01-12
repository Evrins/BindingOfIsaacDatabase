//
//  FilterModel.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/6/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation
import ObjectMapper

class FilterModel: NSObject, Mappable {
    var filterName = ""
    var filterValue = ""
    var filterType = ""
    var active = false
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        filterName <- map["filterName"]
        filterValue <- map["filterValue"]
        filterType <- map["filterType"]
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
}
