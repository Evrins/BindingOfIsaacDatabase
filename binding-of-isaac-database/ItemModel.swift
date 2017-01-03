//
//  ItemModel.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class ItemModel: Object, Mappable {
    dynamic var itemKey = UUID().uuidString
    dynamic var itemName: String? = nil
    dynamic var itemId: String? = nil
    dynamic var itemQuote: String? = nil
    dynamic var itemDescription: String? = nil
    dynamic var itemType: String? = nil
    dynamic var itemPool: String? = nil
    dynamic var itemTags: String? = nil
    dynamic var rechargeTime: String? = nil
    dynamic var globalType: String? = nil
    dynamic var game: String? = nil
//    var itemImage: UIImage? = nil
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "itemKey"
    }
    
    // Mappable
    func mapping(map: Map) {
        itemName <- map["itemName"]
        itemId <- map["itemId"]
        itemQuote <- map["itemQuote"]
        itemDescription <- map["itemDescription"]
        itemType <- map["itemType"]
        itemPool <- map["itemPool"]
        itemTags <- map["itemTags"]
        rechargeTime <- map["rechargeTime"]
        globalType <- map["globalType"]
        game <- map["game"]
//        itemImage <- map["itemImage"]
    }
    
    // Mark: Getters
    
    func getItemName() -> String? {
        return self.itemName
    }
    
    func getItemId() -> String? {
        return self.itemId
    }
    
    func getItemQuote() -> String? {
        return self.itemQuote
    }
    
    func getItemDescription() -> String? {
        return self.itemDescription
    }
    
    func getItemType() -> String? {
        return self.itemType
    }
    
    func getItemPool() -> String? {
        return self.itemPool
    }
    
    func getItemTags() -> String? {
        return self.itemTags
    }
    
    func getRechargeTime() -> String? {
        return self.rechargeTime
    }
    
    func getGlobalType() -> String? {
        return self.globalType
    }
    
    func getGame() -> String? {
        return self.game
    }
    
//    func getItemImage() -> UIImage? {
//        return self.itemImage
//    }
}

