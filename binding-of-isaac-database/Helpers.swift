//
//  Helpers.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/24/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import Foundation
import UIKit

class Helpers: NSObject {
    static let sharedInstance = Helpers()
    private override init() {}

    func randomSequenceGenerator(min: Int, max: Int) -> () -> Int {
        var numbers: [Int] = []
        return {
            if numbers.count == 0 {
                numbers = Array(min ... max)
            }
            
            let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.remove(at: index)
        }
    }
}

extension CGPoint {
    static var Center: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.maxX/2, y: UIScreen.main.bounds.maxY/2)
    }
}

//extension UIColor {
//    
//    /**
//     Creates a UIColor object for the given hex value which can be specified
//     as HTML hex color value. For example:
//     
//     let color = UIColor(hex: 0x8046A2)
//     let colorWithAlpha = UIColor(hex: 0x8046A2, alpha: 0.5)
//     
//     - parameter hex: color value as Int. To be specified as hex literal like 0xff00ff
//     - parameter alpha: alpha optional alpha value (default 1.0)
//     */
//    convenience init(hex: Int, alpha: CGFloat = 1.0) {
//        let r = CGFloat((hex & 0xff0000) >> 16) / 255
//        let g = CGFloat((hex & 0x00ff00) >>  8) / 255
//        let b = CGFloat((hex & 0x0000ff)      ) / 255
//        
//        self.init(red: r, green: g, blue: b, alpha: alpha)
//    }
//    
//}
