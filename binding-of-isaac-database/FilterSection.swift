//
//  FilterSection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/12/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation

class FilterSection: NSObject {
    var sectionTitle = ""
    var sectionFilters: [FilterModel]? = []
    
    init?(sectionTitle: String, sectionfilters: [FilterModel]) {
        self.sectionTitle = sectionTitle
        self.sectionFilters = sectionfilters
    }
    
    convenience init?(sectionTitle: String) {
        self.init(sectionTitle: sectionTitle, sectionfilters: [])
    }
    
    func getSectionTitle() -> String {
        return sectionTitle
    }
    
    func getSectionFilters() -> [FilterModel]? {
        return sectionFilters
    }
    
    func setSectionTitle(to: String) {
        self.sectionTitle = to
    }
    
    func addFilterToSection(filter: FilterModel) {
        sectionFilters?.append(filter)
    }
}
