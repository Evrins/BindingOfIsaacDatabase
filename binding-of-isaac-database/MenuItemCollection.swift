//
//  MenuItemCollection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/27/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation
import SwifterSwift

class MenuItemCollection: NSObject {
    
    var onComplete: ((() -> Void))?
    var setActive: ((() -> Void))?
    
    static let sharedInstance = MenuItemCollection()
    private override init() {}
    
    var menuItems = [MenuItem]()
    
    var menuTitles = [
        "Search",
        "Items",
        "Trinkets",
        "Cards and Runes",
        "Pickups",
//        "Achievements",
//        "Transformations",
//        "Seeds",
        "Pills",
//        "Monsters",
//        "Bosses",
//        "Characters",
//        "Objects",
//        "Curses",
//        "Floors",
//        "Rooms",
//        "Challenges",
//        "Babies (Co-op)",
//        "Collection",
//        "Settings"
        "Contact"
    ]
    
    func loadMenuItems() {
        menuTitles.forEach { title in
            let type = title.camelCased
            var newItem = MenuItem(title: title, type: type)
            if title == "Search" {
                newItem = MenuItem(title: title, type: type, active: true)
            }
            menuItems.append(newItem)
        }
        setActive?()
        onComplete?()
    }
    
    func setActiveItem(to newActiveItem: MenuItem) {
        menuItems.forEach { (item) in
            item.active = false
            if item == newActiveItem {
                item.active = true
            }
        }
        setActive?()
    }
    
    func getActive() -> MenuItem {
        let activeItem = menuItems.filter { $0.active == true }.first
        if activeItem != nil {
            return activeItem!
        }
        return MenuItem(title: "", type: "")
    }
    
    func getMenuItems() -> [MenuItem] {
        return self.menuItems
    }
}
