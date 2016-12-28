//
//  MenuTableViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/27/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import Shoyu
import RealmSwift

class MenuTableViewController: UITableViewController {
    
    let menuItemCollection = MenuItemCollection.sharedInstance
    
    var menuItems = [MenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menu"
        
        menuItemCollection.onComplete = { complete in
            self.menuItems = self.menuItemCollection.getMenuItems()
            self.setUpTable()
        }
        
        menuItemCollection.loadMenuItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(dismissView))
        
    }
    
    func setUpTable() {
        tableView.source = Source() { source in
            
            source.createSection { section in
                section.createRows(for: menuItems, closure: { menuItem, row in
                    row.reuseIdentifier = "Cell"
                    row.height = 40
                    row.configureCell = { cell, _ in
                        cell.textLabel?.text = menuItem.title
                    }
                    row.didSelect = { _ in
                        
                        if let index = self.tableView.indexPathForSelectedRow{
                            self.tableView.deselectRow(at: index, animated: true)
                        }
                        self.dismissView()
                    }
                })
            }
        }
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
