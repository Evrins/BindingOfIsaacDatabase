//
//  DataSource.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import SwiftyJSON

class DataSource {
    static func loadItems(_ completionHandler:@escaping (Bool) -> ()) {
        let realm = try! Realm()
//        guard realm.isEmpty else {return}
        
        try! realm.write {
            realm.deleteAll()
        }
        
        if let url = Bundle.main.url(forResource: "BoI Items", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                
                let json = JSON(data: jsonData)
                
                for item in json["Rebirth Items"].arrayValue {
                    let newItem = ItemModel(JSONString: "\(item)")
                    
                    try! realm.write {
                        realm.add(newItem!)
                    }
                }
                
                for item in json["Rebirth Trinkets"].arrayValue {
                    let newItem = ItemModel(JSONString: "\(item)")
                    
                    try! realm.write {
                        realm.add(newItem!)
                    }
                }
                
                for item in json["Afterbirth Items"].arrayValue {
                    let newItem = ItemModel(JSONString: "\(item)")
                    
                    try! realm.write {
                        realm.add(newItem!)
                    }
                }
                
                for item in json["Afterbirth Trinkets"].arrayValue {
                    let newItem = ItemModel(JSONString: "\(item)")
                    
                    try! realm.write {
                        realm.add(newItem!)
                    }
                }
                
                completionHandler(true)
            } catch {
                // Handle Error
                print("There was an issue loading from JSON")
                completionHandler(false)
            }
        }
        
//        if let url = Bundle.main.url(forResource: "Rebirth Items", withExtension: "json") {
//            do {
//                let jsonData = try Data(contentsOf: url)
//               
//                let json = JSON(data: jsonData)
//                
//                for item in json["Rebirth Items"].arrayValue {
//                    let newItem = ItemModel(JSONString: "\(item)")
//                    
//                    try! realm.write {
//                        realm.add(newItem!)
//                    }
//                }
//                completionHandler(true)
//            } catch {
//                // Handle Error
//                completionHandler(false)
//            }
//        }
//        
//        if let url = Bundle.main.url(forResource: "Rebirth Trinkets", withExtension: "json") {
//            do {
//                let jsonData = try Data(contentsOf: url)
//                
//                let json = JSON(data: jsonData)
//                
//                for item in json["Rebirth Trinkets"].arrayValue {
//                    let newItem = ItemModel(JSONString: "\(item)")
//                    
//                    try! realm.write {
//                        realm.add(newItem!)
//                    }
//                }
//                completionHandler(true)
//            } catch {
//                // Handle Error
//                completionHandler(false)
//            }
//        }
        
    }
    
}
