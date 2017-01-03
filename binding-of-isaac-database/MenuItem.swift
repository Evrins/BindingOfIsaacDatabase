//
//  MenuItem.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/27/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    var title = ""
    var image: UIImage? = nil
    var type = ""
    
    init?(title: String, image: UIImage?, type: String) {
        self.title = title
        self.image = image
        self.type = type
    }
    
    convenience init(title: String, type: String) {
        self.init(title: title, image: nil, type: type)!
    }
}
