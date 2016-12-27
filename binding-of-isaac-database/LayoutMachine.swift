//
//  LayoutMachine.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation

enum LayoutMachine {
    case Grid
//    case Color
    case List
    
    mutating func next() {
        switch self {
        case .Grid: self = .List
//        case .Color: self = .List
        case .List: self = .Grid
        }
    }
}
