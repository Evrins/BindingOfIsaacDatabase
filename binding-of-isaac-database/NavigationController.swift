//
//  NavController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/17/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit
import SideMenu
import SnapKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Stylesheet.applyOn(self)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return Stylesheet.Contexts.Global.StatusBarStyle
    }
}

extension UISideMenuNavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Stylesheet.applyOn(self)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return Stylesheet.Contexts.Global.StatusBarStyle
    }
}
