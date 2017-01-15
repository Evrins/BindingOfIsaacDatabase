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

public class Value: Object {
    public dynamic var value: String?
}

class ItemModel: Object, Mappable {
    dynamic var itemKey = UUID().uuidString
    dynamic var itemName: String? = nil
    dynamic var itemId: String? = nil
    dynamic var itemQuote: String? = nil
    dynamic var itemDescription: String? = nil
    dynamic var mainType: String? = nil
    dynamic var subType: String? = nil
    public let itemPool = List<Value>()
    dynamic var itemTags: String? = nil
    dynamic var rechargeTime: String? = nil
    dynamic var itemUnlock: String? = nil
    dynamic var globalType: String? = nil
    dynamic var game: String? = nil
    
    override static func primaryKey() -> String? {
        return "itemKey"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        itemName <- map["itemName"]
        itemId <- map["itemId"]
        itemQuote <- map["itemQuote"]
        itemDescription <- map["itemDescription"]
        mainType <- map["mainType"]
        subType <- map["subType"]
        
        itemTags <- map["itemTags"]
        rechargeTime <- map["rechargeTime"]
        itemUnlock <- map["itemUnlock"]
        globalType <- map["globalType"]
        game <- map["game"]
        
        var itemPoolString: String? = nil
        var options: [String]? = nil
        itemPoolString <- map["itemPool"] // Maps to local variable
        
        options = itemPoolString?.components(separatedBy: ",")
        
        options?.forEach { option in // Then fill options to `List`
            let value = Value()
            value.value = option.trimmingCharacters(in: .whitespaces)
            self.itemPool.append(value)
        }

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
    
    func getMainType() -> String? {
        return self.mainType
    }
    
    func getSubType() -> String? {
        return self.subType
    }
    
    func getItemPool() -> List<Value> {
        return self.itemPool
    }
    
    func getItemPoolString() -> String {
        var itemPools = [String]()
        for item in self.itemPool {
            itemPools.append(item.value!)
        }
        
        return itemPools.joined(separator: ", ")
    }
    
    func getItemTags() -> String? {
        return self.itemTags
    }
    
    func getRechargeTime() -> String? {
        return self.rechargeTime
    }
    
    func getItemUnlock() -> String? {
        return self.itemUnlock
    }
    
    func getGlobalType() -> String? {
        return self.globalType
    }
    
    func getGame() -> String? {
        return self.game
    }
    
    func getImageUrl() -> URL? {
        //@TODO: Check if trinket name is used
        
        let placeholderUrl: URL? = Bundle.main.url(forResource: "ImageNotFoundPlaceholder", withExtension: ".png")
        
        var url: URL? = nil
        var resourceString: String? = self.getItemId()
        
        if resourceString == nil {
            resourceString = self.getItemName()
        }
        
        url = Bundle.main.url(forResource: resourceString, withExtension: ".png")
        
        if url == nil {
            url = placeholderUrl
        }
        
        return url
    }
}

