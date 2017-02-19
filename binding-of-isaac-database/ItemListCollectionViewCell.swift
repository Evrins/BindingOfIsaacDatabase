//
//  ItemListCollectionViewCell.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

//import UIKit
//
//class ItemListCollectionViewCell: UICollectionViewCell, CellInterface {
//    @IBOutlet weak var itemImage: UIImageView!
//    @IBOutlet weak var itemTitle: UILabel!
//    @IBOutlet weak var itemQuote: UILabel!
//
//}

import UIKit
import Reusable
import SnapKit
import Font_Awesome_Swift

class ItemListCollectionViewCell: UICollectionViewCell, Reusable {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    var checkmarkImageView = UIImageView()
    
    let leftImageContentView = UIView()
    let rightImageContentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Have to remake constraints since it uses contentView.size
        leftImageContentView.snp.remakeConstraints { (make) -> Void in
            make.height.equalToSuperview()
            make.width.equalTo(contentView.width / 6)
            
            make.left.equalToSuperview()
        }
        
        rightImageContentView.snp.remakeConstraints { (make) -> Void in
            make.height.equalToSuperview()
            make.width.equalTo(contentView.width / 6)
            
            make.right.equalToSuperview()
        }
    }
    
    func setupConstraints() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(leftImageContentView)
        self.contentView.addSubview(rightImageContentView)
        
        self.leftImageContentView.addSubview(imageView)
        self.rightImageContentView.addSubview(checkmarkImageView)
        
        contentView.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.magnificationFilter = kCAFilterNearest
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.layer.magnificationFilter = kCAFilterNearest
        
        leftImageContentView.snp.makeConstraints { (make) -> Void in
            make.height.equalToSuperview()
            make.width.equalTo(contentView.width / 6)
            
            make.left.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            let inset = 5
            make.edges.equalToSuperview().inset(inset)
        }
        
        rightImageContentView.snp.makeConstraints { (make) -> Void in
            make.height.equalToSuperview()
            make.width.equalTo(contentView.width / 6)
            
            make.right.equalToSuperview()
        }
        
        checkmarkImageView.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            let inset = 5
            make.edges.equalToSuperview().inset(inset)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview().inset(-10)
            make.left.equalTo(leftImageContentView.snp.right).inset(-5)
            make.right.equalTo(rightImageContentView.snp.left).inset(5)
        }
        
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview().inset(10)
            make.left.equalTo(leftImageContentView.snp.right).inset(-5)
            make.right.equalTo(rightImageContentView.snp.left).inset(5)
        }
    }
    
    func setupCell(item: ItemModel) {
        if let itemQuote = item.getItemQuote(), item.getItemQuote() != nil {
            detailLabel.text = "\"\(itemQuote)\""
        }
        
        if item.getItemQuote() == nil && item.getItemDescription() != nil {
            detailLabel.text = "\(item.getItemDescription()!)"
        }
        
        titleLabel.text = item.getItemName()
        
        let url: URL? = item.getImageUrl()
        if url != nil {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
        
        if item.isCollected() {
            checkmarkImageView.image = UIImage.init(icon: .FACheckCircleO, size: CGSize(width: 200, height: 200), textColor: .green)
            return
        }
        
        checkmarkImageView.image = UIImage()
    }
}
