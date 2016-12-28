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
    
    init?(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    convenience init(title: String) {
        self.init(title: title, image: nil)!
    }
}
