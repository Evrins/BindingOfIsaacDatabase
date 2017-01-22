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
    
    var titleLabel = UILabel()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        Stylesheet.applyOn(self)
        self.setUpTitleLabelText()
        self.addSubview(titleLabel)
        
        self.frame = titleLabel.frame
    }
    
    func setUpTitleLabelText() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        let title = menuItemCollection.getActive().title
        titleLabel.text = title
        
        if title == "Items" {
            titleLabel.text = title + "\n" + "(Tap to Add Filter)"
            // @TODO: Find a better way to do this dynamically
            titleLabel.font = UIFont(name: Stylesheet.Fonts.Regular, size: 18.0)
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
            let navController = UINavigationController(rootViewController: vc)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(navController, animated: true, completion: nil)
        }

    }

}
