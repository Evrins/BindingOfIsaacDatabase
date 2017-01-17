//
//  Stylesheet.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/28/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import SwifterSwift

// MARK: - Stylesheet
enum Stylesheet {
    
    enum Colors {
        static let White = UIColor(hex: 0xFFFFFF)
        static let Tan = UIColor(hex: 0xC7B29A)
        static let DarkTan = UIColor(hex: 0xB09C87)
        static let DarkBrown = UIColor(hex: 0x362F2D)
        static let DarkRed = UIColor(hex: 0x771C00)
        static let LightRed = UIColor(hex: 0xFF4B29)
        // Colors borrowed from Tweetbot's dark color scheme
    }
    
    enum Fonts {
        static let Regular = "Avenir-Light"
        static let Bold = "Avenir-Medium"
    }
    
    enum Contexts {
        enum Global {
            static let StatusBarStyle = UIStatusBarStyle.lightContent
            static let BackgroundColor = Colors.DarkBrown
        }
        
        enum NavigationController {
            static let BarTintColor = Colors.DarkTan
            static let BarTextColor = Colors.DarkBrown
            static let BarColor = Colors.DarkBrown
        }
        
//        enum CountdownListCell {
//            static let BackgroundColor = Colors.Black
//            static let TitleTextColor = Colors.Blue
//        }
//        
//        enum CountdownDetail {
//            static let EditModeTitle = "Edit Countdown"
//            static let CreationModeTitle = "Create Countdown"
//            
//            static let CellBackgroundColor = Colors.LightGray
//            static let CellSeparatorColor = Colors.LightGray
//            static let CellTextColor = Colors.LightBlue
//            static let DatePickerTextColor = Colors.Blue
//        }
//        
//        enum CountdownView {
//            static let BackgroundColor = Global.BackgroundColor
//            static let CircleColor = Colors.Blue
//            static let ProgressStrokeColor = Colors.LightBlue
//            static let TextColor = Colors.White
//            
//            static let ProgressStrokeWidth = 3.0
//        }
        
    }
    
}

// MARK: - Apply Stylesheet
extension Stylesheet {
    
    static func applyOn(_ navVC: NavigationController) {
        typealias context = Contexts.NavigationController
        navVC.navigationBar.barTintColor = context.BarTintColor
        navVC.navigationBar.tintColor = context.BarColor
        navVC.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: Fonts.Regular, size: 22.0)!, NSForegroundColorAttributeName: context.BarTextColor]
        navVC.navigationBar.isTranslucent = false
    }
    
//    static func applyOn(cell: CountdownListCell) {
//        typealias context = .CountdownListCell
//        cell.backgroundColor = context.BackgroundColor
//        cell.contentView.backgroundColor = context.BackgroundColor
//        
//        cell.titleLabel.textColor = context.TitleTextColor
//        cell.titleLabel.font = UIFont(name: Fonts.Regular, size: 24.0)
//    }
    
}
