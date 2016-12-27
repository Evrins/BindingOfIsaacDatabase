//
//  CellInterface.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

protocol CellInterface {
    
    static var id: String { get }
    static var cellNib: UINib { get }
    
}

extension CellInterface {
    
    static var id: String {
        return String(describing: Self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
}
