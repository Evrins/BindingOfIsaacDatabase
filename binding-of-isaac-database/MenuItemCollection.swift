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
    
    static let sharedInstance = MenuItemCollection()
    private override init() {}
    
    var menuItems = [MenuItem]()
    
    var menuTitles = [
        "Search",
        "Items",
        "Trinkets",
        "Cards and Runes",
        "Pickups",
        /*
        "Achievements",
        "Transformations",
        "Seeds",
         */
        "Pills",
        /*
        "Monsters",
        "Bosses",
        "Characters",
        "Objects",
        "Curses",
        "Floors",
        "Rooms",
        "Challenges",
        "Babies (Co-op)",
         */
        "Collection",
        "Settings"
    ]
    
    func loadMenuItems() {
        menuTitles.forEach { title in
            let type = title.camelCased
            let newItem = MenuItem(title: title, type: type)
            menuItems.append(newItem)
        }
        onComplete?()
    }
    

    func getMenuItems() -> [MenuItem] {
        return self.menuItems
    }
}
