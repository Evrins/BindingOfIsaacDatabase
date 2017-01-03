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
        static let Black = UIColor(hex: 0x262626)
        static let DarkGray = UIColor(hex: 0x333333)
        static let LightGray = UIColor(hex: 0x787878)
        static let Blue = UIColor(hex: 0x7AA0CC)
        static let LightBlue = UIColor(hex: 0x9AC9FF)
        // Colors borrowed from Tweetbot's dark color scheme
    }
    
    enum Fonts {
        static let Regular = "Avenir-Light"
        static let Bold = "Avenir-Medium"
    }
    
    enum Contexts {
        enum Global {
            static let StatusBarStyle = UIStatusBarStyle.lightContent
            static let BackgroundColor = Colors.DarkGray
        }
        
        enum NavigationController {
            static let BarTintColor = Colors.Black
            static let BarTextColor = Colors.White
            static let BarColor = Colors.LightGray
        }
        
        enum CountdownListCell {
            static let BackgroundColor = Colors.Black
            static let TitleTextColor = Colors.Blue
        }
        
        enum CountdownDetail {
            static let EditModeTitle = "Edit Countdown"
            static let CreationModeTitle = "Create Countdown"
            
            static let CellBackgroundColor = Colors.LightGray
            static let CellSeparatorColor = Colors.LightGray
            static let CellTextColor = Colors.LightBlue
            static let DatePickerTextColor = Colors.Blue
        }
        
        enum CountdownView {
            static let BackgroundColor = Global.BackgroundColor
            static let CircleColor = Colors.Blue
            static let ProgressStrokeColor = Colors.LightBlue
            static let TextColor = Colors.White
            
            static let ProgressStrokeWidth = 3.0
        }
        
    }
    
}

// MARK: - Apply Stylesheet
extension Stylesheet {
    
//    static func applyOn(cell: CountdownListCell) {
//        typealias context = Stylesheet.Contexts.CountdownListCell
//        cell.backgroundColor = context.BackgroundColor
//        cell.contentView.backgroundColor = context.BackgroundColor
//        
//        cell.titleLabel.textColor = context.TitleTextColor
//        cell.titleLabel.font = UIFont(name: Fonts.Regular, size: 24.0)
//    }
    
}
