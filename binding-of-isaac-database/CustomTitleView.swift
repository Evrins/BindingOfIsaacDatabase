//
//  CustomTitleView.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/13/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit

class CustomTitleView: UIView {
    
    let menuItemCollection = MenuItemCollection.sharedInstance
    
    let titleLabel = UILabel()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.setUpTitleLabelText()
        self.addSubview(titleLabel)
        
        self.frame = titleLabel.frame
    }
    
    func setUpTitleLabelText() {
        titleLabel.numberOfLines = 0
        //@TODO: Set this to bar tint color 
        titleLabel.textColor = Stylesheet.Contexts.NavigationController.BarTextColor
        titleLabel.textAlignment = .center
        
        let title = menuItemCollection.getActive()?.title
        titleLabel.text = title!
        
        if title == "Items" {
            titleLabel.text = title! + "\n" + "(Tap to Add Filter)"
            titleLabel.sizeToFit()
            setUpButton()
        }
        
        titleLabel.sizeToFit()
        
    }
    
    func setUpButton() {
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.frame = titleLabel.frame
        self.addSubview(button)
    }
    
    func buttonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let vc = storyboard.instantiateViewController(withIdentifier: "FilterTableViewController") as? FilterTableViewController {
            
            // Use Cutom Navigation Controller
            let navController = NavigationController(rootViewController: vc)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(navController, animated: true, completion: nil)
        }

    }

}
