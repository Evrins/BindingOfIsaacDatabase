//
//  MenuItemCollection.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/27/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation

class MenuItemCollection: NSObject {
    
    var onComplete: ((_ complete: Bool)->())?
    
    static let sharedInstance = MenuItemCollection()
    private override init() {}
    
    var menuItems = [MenuItem]()
    
    var menuTitles = [
        "Search",
        "Items",
        "Trinkets",
        "Cards and Runes",
        "Pickups",
        "Achievements",
        "Transformations",
        "Seeds",
        "Pills",
        "Monsters",
        "Bosses",
        "Characters",
        "Objects",
        "Curses",
        "Floors",
        "Rooms",
        "Challenges",
        "Babies (Co-op)",
        "Collection",
        "Settings"
    ]
    
    func loadMenuItems() {
        menuTitles.forEach { title in
            let newItem = MenuItem(title: title)
            menuItems.append(newItem)
        }
        onComplete?(true)
    }
    

    func getMenuItems() -> [MenuItem] {
        return self.menuItems
    }
}
