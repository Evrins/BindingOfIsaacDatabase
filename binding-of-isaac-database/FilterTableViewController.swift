//
//  FilterTableViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/12/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift

class FilterTableViewController: UITableViewController {
    
    let itemCollection = ItemCollection.sharedInstance
    let filterCollection = FilterCollection.sharedInstance
    
    var filterSections = [FilterSection?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filters"
        
        self.filterSections = filterCollection.getFiltersBySection()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        
        self.tableView.tableFooterView = UIView()
    }
    
    func saveButtonPressed() {
        //@TODO: Save Filters
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(filterSections[section]?.getSectionFilters())!.isEmpty {
            return (filterSections[section]?.getSectionFilters()!.count)!
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let row = indexPath.row
        let section = indexPath.section
        
        let item = filterSections[section]?.getSectionFilters()?[row]
        cell.textLabel?.text = item?.getFilterName()
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let index = self.tableView.indexPathForSelectedRow{
//            self.tableView.deselectRow(at: index, animated: true)
//        }
//        let menuItem = menuItems[indexPath.row]
//        
//        self.itemCollection.filterGlobalType(by: menuItem.type)
//        
//        if menuItem.title == "Search" {
//            self.itemCollection.setCurrentItemsToLoadedItems()
//        }
//        
//        menuItemCollection.setActiveItem(to: menuItem)
//        
//        self.dismissView()
//    }
}
