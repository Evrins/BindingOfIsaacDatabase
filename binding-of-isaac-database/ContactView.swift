//
//  ContactView.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/19/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit
import SnapKit

class ContactView: UIScrollView {
    var contentView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    var koalaTeaLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KoalaTeaCharacter")
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var githubLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Octocat")
        
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "This app is a Koala Tea product"
        return label
    }()
    
    var visitWebsiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Visit our website:"
        return label
    }()
    
    var websiteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x157efb)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "KoalaTea.io"
        
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    var secondTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Check out this project on GitHub:"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTaps()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContactView {
    func setUpTaps() {
        let websiteTap = UITapGestureRecognizer(target: self, action: #selector(websiteButtonTapped))
        websiteLabel.addGestureRecognizer(websiteTap)
        
        let githubTap = UITapGestureRecognizer(target: self, action: #selector(githubButtonTapped))
        githubLogo.addGestureRecognizer(githubTap)
    }
    
    func websiteButtonTapped(sender: UITapGestureRecognizer) {
        openUrl(urlStr: "http://www.koalatea.io/")
    }
    
    func githubButtonTapped(sender: UITapGestureRecognizer) {
        openUrl(urlStr: "https://github.com/themisterholliday/BindingOfIsaacDatabase")
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = URL(string: urlStr) {
            // Swift
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func setUpView() {
        self.backgroundColor = UIColor(hex: 0xEAEAEA)
        
        self.addSubview(contentView)
        contentView.addSubview(koalaTeaLogo)
        contentView.addSubview(textLabel)
        contentView.addSubview(secondTextLabel)
        contentView.addSubview(visitWebsiteLabel)
        contentView.addSubview(websiteLabel)
        contentView.addSubview(githubLogo)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        self.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView.snp.bottom).inset(-50)
        }
        
        koalaTeaLogo.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).inset(5)
            make.left.equalTo(contentView.snp.left).inset(40)
            make.right.equalTo(contentView.snp.right).inset(40)
            
            make.size.height.equalTo(200)
        }
        
        textLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(koalaTeaLogo.snp.bottom).inset(-10)
            make.left.equalTo(contentView.snp.left).inset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            
            //            make.size.height.equalTo(20)
        }
        
        visitWebsiteLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(textLabel.snp.bottom).inset(-20)
            make.left.equalTo(contentView.snp.left).inset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            
            //            make.size.height.equalTo(20)
        }
        
        websiteLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(visitWebsiteLabel.snp.bottom).inset(-10)
            make.left.equalTo(contentView.snp.left).inset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            
            //            make.size.height.equalTo(20)
        }
        
        secondTextLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(websiteLabel.snp.bottom).inset(-15)
            make.left.equalTo(contentView.snp.left).inset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            
            make.size.height.equalTo(50)
        }
        
        githubLogo.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(secondTextLabel.snp.bottom).inset(-10)
            make.left.equalTo(contentView.snp.left).inset(40)
            make.right.equalTo(contentView.snp.right).inset(40)
            
            make.size.height.equalTo(200)
        }
    }
}
