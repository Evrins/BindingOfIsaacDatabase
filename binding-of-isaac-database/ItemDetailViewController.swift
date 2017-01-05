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
import SwifterSwift

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedItem: ItemModel? = nil
    lazy var selectedItemProperties: [ItemProperty] = {
        let item = self.selectedItem
        var itemProperties = self.getItemFields(item: item!)
        return itemProperties
    }()
    
    var tableView = UITableView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(cellType: CustomTableViewCell.self)
        tableView.register(cellType: ItemDetailTopCell.self)
        
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        contentView.backgroundColor = .white
        
        contentView.addSubview(tableView)
        view.addSubview(contentView)
        
        setupConstraints()
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
        return selectedItemProperties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.row) {
            case 0:
                let cell = tableView.dequeueReusableCell(for: indexPath) as ItemDetailTopCell
                
                let item = selectedItem
                
                cell.itemImage.layer.magnificationFilter = kCAFilterNearest;
                
                var image: UIImage? = nil
                if let itemId = item?.getItemId() {
                    image = UIImage(named: itemId)
                }
                if image != nil {
                    cell.itemImage.image = image
                }
                
                cell.itemTitleLabel.text = item?.getItemName()
                cell.itemQuoteLabel.text = item?.getItemQuote()
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(for: indexPath) as CustomTableViewCell
                
                let row = indexPath.row - 1
                
                let itemProperty = selectedItemProperties[row]
                
                let attributedString = NSMutableAttributedString()
                
                let keyText  = itemProperty.key
                let keyAttributes = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)]
                let keyString = NSMutableAttributedString(string:keyText, attributes: keyAttributes)
                
                var valueText = itemProperty.value
                
                valueText = convertStringToMultiline(string: valueText!)
                
                let valueAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16)]
                let valueString = NSMutableAttributedString(string: " " + valueText!, attributes: valueAttributes)

                attributedString.append(keyString)
                attributedString.append(valueString)
                
                cell.cellLabel.attributedText = attributedString
                cell.cellDetailLabel.text = ""
                
                if itemProperty.key == "Description:" {
                    cell.cellLabel.attributedText = keyString
                    cell.cellDetailLabel.attributedText = valueString
                }
                
                return cell
        }
        
        
    }
    
    func getItemFields(item: ItemModel) -> [ItemProperty] {
        
        var itemProperties = [
            ItemProperty(key: "ID:", value: item.getItemId()),
            ItemProperty(key: "Description:", value: item.getItemDescription()),
            ItemProperty(key: "Type:", value: item.getItemType()),
            ItemProperty(key: "Item Pool:", value: item.getItemPool()),
            ItemProperty(key: "Recharge Time:", value: item.getRechargeTime()),
            ItemProperty(key: "Unlock:", value: item.getItemUnlock()),
            ItemProperty(key: "Game:", value: item.getGame())
        ]
        
        itemProperties = itemProperties.filter{ $0.value != ""}
        
        return itemProperties
    }
    
    func convertStringToMultiline(string: String) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: 1)
        let endIndex = string.endIndex
        let range = startIndex..<endIndex
        
        let convertedString = string.replacingOccurrences(of: ";", with: "\n\n", options: .regularExpression, range: range)
        
        return convertedString
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
            make.size.equalTo(CGSize(width: 75, height: 75))
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalTo(contentView.snp.left).inset(15)
        }
        itemTitleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(itemImage.snp.centerY).inset(-5)
            make.left.equalTo(itemImage.snp.right).inset(-20)
        }
        itemQuoteLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(itemTitleLabel.snp.bottom)
            make.left.equalTo(itemTitleLabel.snp.left)
        }
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(itemImage.snp.bottom).inset(-10)
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
        self.cellLabel.numberOfLines = 0
        self.cellLabel.lineBreakMode = .byWordWrapping
        self.cellDetailLabel.sizeToFit()
        self.cellDetailLabel.numberOfLines = 0
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(5)
        }
        cellDetailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cellLabel.snp.bottom)
            make.left.equalTo(cellLabel.snp.left).inset(5)
            make.right.equalTo(cellLabel.snp.right)
        }
        contentView.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(cellLabel.snp.bottom).inset(0).priority(250)
            make.bottom.equalTo(cellDetailLabel.snp.bottom).inset(0).priority(260)
        }
    }
}

struct ItemProperty {
    let key: String
    let value: String?
}
