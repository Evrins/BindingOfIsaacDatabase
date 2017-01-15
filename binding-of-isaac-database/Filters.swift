//
//  Filters.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/6/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation

enum Filters {
    
    enum GlobalType {
        static let Item = "item"
        static let Trinket = "trinket"
    }
    
    enum Game {
        static let Rebirth = "rebirth"
        static let Afterbirth = "afterbirth"
        static let AfterbirthPlus = "afterbirthPlus"
    }
    
    enum ItemAttribute {
        static let ItemName = "itemName"
        static let ItemId = "itemId"
        static let ItemQuote = "itemQuote"
        static let ItemDescription = "itemDescription"
        static let MainType = "mainType"
        static let SubType = "subType"
        static let ItemPool = "itemPool"
        static let ItemTags = "itemTags"
        static let RechargeTime = "rechargeTime"
        static let ItemUnlock = "itemUnlock"
        static let GlobalType = "globalType"
        static let Game = "game"
        
        static let allValues = [
            ItemAttribute.ItemName,
            ItemAttribute.ItemId,
            ItemAttribute.ItemQuote,
            ItemAttribute.ItemDescription,
            ItemAttribute.MainType,
            ItemAttribute.SubType,
            ItemAttribute.ItemPool,
            ItemAttribute.ItemTags,
            ItemAttribute.RechargeTime,
            ItemAttribute.ItemUnlock,
            ItemAttribute.GlobalType,
            ItemAttribute.Game
        ]
    }
    
    enum MainType {
        static let All = "All"
        static let Active = "Active"
        static let Passive = "Passive"
        
        static let allValues = [
            MainType.All,
            MainType.Passive,
            MainType.Active
        ]
    }
    
    enum SubType {
        static let All = "All"
        static let TearModifier = "Tear Modifier"
        static let Familiar = "Familiar"
        static let Orbital = "Orbital"
    }
    
    enum ItemPools {
        static let All = "All"
        static let Shop = "Shop"
        static let TreasureRoom = "Treasure Room"
        static let BossRoom = "Boss Room"
        static let Beggar = "Beggar"
        static let CurseRoom = "Curse Room"
        static let Library = "Library"
        static let ChallengeRoom = "Challenge Room"
        static let DevilRoom = "Devil Room"
        static let AngelRoom = "Angel Room"
        static let SecretRoom = "Secret Room"
        static let BombBeggar = "Bomb Beggar"
        static let RedChest = "Red Chest"
        static let DemonBeggar = "Demon Beggar"
        static let GoldChest = "Gold Chest"
        static let BossRush = "Boss Rush"
        static let KeyBeggar = "Key Beggar"
        // Greed Mode
        static let GreedMode = "Greed Mode"
        static let LibraryGM = "Library (Greed Mode)"
        static let BossGM = "Boss (Greed Mode)"
        static let ShopGM = "Shop (Greed Mode)"
        static let CurseRoomGM = "Curse Room (Greed Mode)"
        static let TreasureRoomGM = "Treasure Room (Greed Mode)"
        static let AngelRoomGM = "Angel Room (Greed Mode)"
        static let GoldChestGM = "Gold Chest (Greed Mode)"
        static let SecretRoomGM = "Secret Room (Greed Mode)"
        static let DevilRoomGM = "Devil Room (Greed Mode)"
    }

}


