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
    let realm = try! Realm()

    var sectionTitles = ["Game","Main Type","Sub Type","Item Pool"]
    var filtersBySection = [Results<FilterModel>]()
    
    var notificationTokens = [NotificationToken]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filters"
        
        for (index, section) in sectionTitles.enumerated() {
            let unsorted = realm.objects(FilterModel.self).filter("headerType == %@" , section)
            filtersBySection.append(unsorted)
            registerNotifications(for: filtersBySection[index], in: index)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.tableFooterView = UIView()
    }
    //@TODO: ADD undo button
    func saveButtonPressed() {
        itemCollection.filterByAllFilters()
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filtersBySection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersBySection[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitle = "This means nothing for some reason but is needed"
        
        return headerTitle
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.text = sectionTitles[section]
        header.textLabel!.textColor = .white
        header.contentView.backgroundColor = .gray
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = filtersBySection[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.getFilterName()

        cell.tintColor = .black
        configureChecked(for: cell, with: item)
        
        return cell
    }
    
    func configureChecked(for cell: UITableViewCell, with item: FilterModel) {
        if item.active {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filtersBySection[indexPath.section][indexPath.row]
        
        try! realm.write {
            item.toggleActive()
        }
        
        let filterItemsToUncheck = filtersBySection[indexPath.section].filter({$0.filterName != item.filterName})
        
        for filter in filterItemsToUncheck {
            if filter.isActive() {
                try! realm.write {
                    filter.active = false
                }
            }
        }
        
        //@TODO: If no filters are active, set All item to active
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilterTableViewController {
    func registerNotifications(for results: Results<FilterModel>, in section:Int) {
        
        let notificationToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: section) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: section)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: section) }), with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
        notificationTokens.append(notificationToken)
    }
}
