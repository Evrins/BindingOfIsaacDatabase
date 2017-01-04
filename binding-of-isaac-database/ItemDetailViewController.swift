//
//  ItemDetailViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/24/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import SnapKit

class ItemDetailViewController: UIViewController {        
    var selectedItem: ItemModel? = nil
    let itemImage = UIImageView()
    let itemTitleLabel = UILabel()
    let itemQuoteLabel = UILabel()
    
    let menuItemCollection = MenuItemCollection.sharedInstance
    
    var menuItems = [MenuItem]()
    
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
        
        self.menuItems = self.menuItemCollection.getMenuItems()

        setUpTable()
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
    
    func setUpTable() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.source = Source() { source in
            source.createSection { section in
                section.createRows(for: menuItems, closure: { (menuItem, row: Row<CustomTableViewCell>) in
                    row.reuseIdentifier = "Cell"
                    row.height = 40
                    row.configureCell = { cell, _ in
                        cell.cellLabel.text = menuItem.title
                    }
                })
            }
            
        }
    }

   
}

class CustomTableViewCell: UITableViewCell {
    let cellLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cellLabel)
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { (make) -> Void in
            make.size.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }
    }
}
