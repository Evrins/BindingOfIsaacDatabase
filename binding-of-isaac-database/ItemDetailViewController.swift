//
//  ItemDetailViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/24/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedItem: ItemModel? = nil
    lazy var selectedItemProperties: [String : String] = {
        let item = self.selectedItem
        var itemProperties = self.getItemFields(item: item!)
        return itemProperties
    }()
    
    var tableView = UITableView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        
//        itemTitleLabel.text = selectedItem?.getItemName()
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.sizeToFit()
        
        itemQuoteLabel.text = selectedItem?.getItemQuote()
        
//        itemImage.layer.magnificationFilter = kCAFilterNearest;
        // @TODO: Make image optional
//        let image: UIImage? = UIImage(named: (selectedItem?.getItemId()!)!)
//        if image != nil {
//            itemImage.image = image
//        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(cellType: CustomTableViewCell.self)
        
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        contentView.backgroundColor = .white
        
        contentView.addSubview(tableView)
        view.addSubview(contentView)
        
        setupConstraints()
        
        self.getItemFields(item: selectedItem!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp.edges)
        }
        
    }
    
}

extension ItemDetailViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuItems.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CustomTableViewCell
        
        let row = indexPath.row
        
//        cell.cellLabel.text = menuItems[row].title
        cell.cellLabel.text = "Title"
        cell.cellDetailLabel.text = "Line 1" + "\n" + "Line 2" + "\n" + "Line 3"
        
        return cell
    }
    
    func getItemFields(item: ItemModel) -> [String: String] {
        var itemProperties: [String : String?] = [
            "Name" : item.getItemName(),
            "ID:" :item.getItemId(),
            "Qoute" :item.getItemQuote(),
            "Description:" :item.getItemDescription(),
            "Type:" :item.getItemType(),
            "Item Pool:" :item.getItemPool(),
            "Recharge Time:" :item.getRechargeTime(),
            "Game:" :item.getGame()
        ]
        
        for (key, value) in itemProperties {
            if value == nil || value == "" {
                itemProperties.removeValue(forKey: key)
            }
        }
        
        return itemProperties as! [String: String]
    }
}

class ItemDetailTopCell: UITableViewCell, Reusable {
    let itemImage = UIImageView()
    let itemTitleLabel = UILabel()
    let itemQuoteLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(itemImage)
        self.contentView.addSubview(itemTitleLabel)
        self.contentView.addSubview(itemQuoteLabel)
        
        self.itemTitleLabel.sizeToFit()
        self.itemQuoteLabel.sizeToFit()
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupConstraints() {
        itemImage.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        cellLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).inset(5)
            make.left.equalToSuperview().inset(10)
        }
        cellDetailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cellLabel.snp.bottom)
            make.left.equalTo(cellLabel.snp.left).inset(5)
        }
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(cellDetailLabel.snp.bottom).inset(-10)
        }
    }
}

class CustomTableViewCell: UITableViewCell, Reusable {
    let cellLabel = UILabel()
    let cellDetailLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cellLabel)
        self.contentView.addSubview(cellDetailLabel)
        
        self.cellLabel.sizeToFit()
        self.cellDetailLabel.sizeToFit()
        self.cellDetailLabel.numberOfLines = 0
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).inset(5)
            make.left.equalToSuperview().inset(10)
        }
        cellDetailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cellLabel.snp.bottom)
            make.left.equalTo(cellLabel.snp.left).inset(5)
        }
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(cellDetailLabel.snp.bottom).inset(-10)
        }
    }
}
