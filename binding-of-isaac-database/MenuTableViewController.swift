//
//  MenuTableViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/27/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift

class MenuTableViewController: UITableViewController {
    
    let itemCollection = ItemCollection.sharedInstance
    let menuItemCollection = MenuItemCollection.sharedInstance
    
    var menuItems = [MenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menu"
        
        menuItemCollection.onComplete = { _ in
            self.menuItems = self.menuItemCollection.getMenuItems()
        }
        
        menuItemCollection.loadMenuItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(dismissView))
        
        self.tableView.tableFooterView = UIView()
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MenuTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let row = indexPath.row
        
        cell.textLabel?.text = menuItems[row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        let menuItem = menuItems[indexPath.row]
        self.itemCollection.filterItemsByProperty(property: menuItem.type, itemAttribute: "globalType")

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        vc.viewTitle = menuItem.title
        
        self.dismissView()
    }
}
