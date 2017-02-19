//
//  PlaceholderView.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/15/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit
import SnapKit

class PlaceHolderView: UIView {
    let itemColletion = ItemCollection.sharedInstance
    
    var searchText: String = "" {
        didSet {
            //@TODO: Clean this up
            self.searchTextLabel.text = "\"" + searchText + "\""
            self.placeholderTextLabel.text = "No results found for:"
            
            if searchText.isEmpty {
                self.searchTextLabel.text = searchText
                self.placeholderTextLabel.text = "Type in the search bar to start searching."
            }
        }
    }
    var searchTextLabel = UILabel()
//    var placeholderImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Judas")
//        
//        imageView.layer.magnificationFilter = kCAFilterNearest
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
    
    var placeholderTextLabel: UILabel = {
        //@TODO: Change text color
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Type in the search bar to start searching."
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.backgroundColor = UIColor(hex: 0xEAEAEA)
        
        self.setUpTitleLabelText()
        self.addSubview(searchTextLabel)
        self.addSubview(placeholderTextLabel)
//        self.addSubview(placeholderImage)
        
        self.setupConstraints()
        
        self.frame = UIScreen.main.bounds
    }
    
    func setPlaceholderLabelText() {
        placeholderTextLabel.text = "Type in the search bar to start searching."
        
        if itemColletion.getItems() != nil && itemColletion.getItems().isEmpty {
            placeholderTextLabel.text = "No items meet your filter criteria." + "\n" + "Try expanding your filter settings."
        }
    }
    
    func setUpTitleLabelText() {
        //@TODO: Change text color
        searchTextLabel.numberOfLines = 0
        searchTextLabel.textAlignment = .center
        
        searchTextLabel.sizeToFit()
    }
    
    func setupConstraints() {
        
        searchTextLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(placeholderTextLabel.snp.bottom)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
//            make.bottom.equalTo(collectionView.snp.top)
        }
        
        placeholderTextLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).inset(30)
        }
        
//        placeholderImage.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(self.snp.centerX)
//            make.top.equalTo(self.searchTextLabel.snp.bottom).inset(-10).priority(251)
//            make.top.equalTo(self.placeholderTextLabel.snp.bottom).inset(-10).priority(250)
//            
//            make.size.equalTo(CGSize(width: 200, height: 200))
//        }
    }
}

