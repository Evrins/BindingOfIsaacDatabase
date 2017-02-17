//
//  ItemCollectionViewCell.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/19/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

//import UIKit
//
//class ItemCollectionViewCell: UICollectionViewCell, CellInterface {
//    @IBOutlet weak var itemImage: UIImageView!
//    @IBOutlet weak var itemTitle: UILabel!
//    
//    
//}

import UIKit
import Reusable
import SnapKit
import Font_Awesome_Swift
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell, Reusable {
    let imageView = UIImageView()
    let checkmarkImageView = UIImageView()
    let imageContentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupConstraints() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(checkmarkImageView)
        
        contentView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.magnificationFilter = kCAFilterNearest
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            let inset = 0
            make.edges.equalToSuperview().inset(inset)
        }
        
        checkmarkImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func setupCell(item: ItemModel) {
        let size = imageView.size.height / 2
        let imageSize = CGSize(width: size, height: size)
        
        if item.globalType != "items" {
            checkmarkImageView.image = UIImage()
        }
        
        checkmarkImageView.image = UIImage.init(icon: .FACheckCircleO, size: imageSize, textColor: .gray, backgroundColor: .clear)
        
        if item.isCollected() {
            checkmarkImageView.image = UIImage.init(icon: .FACheckCircleO, size: imageSize, textColor: .green, backgroundColor: .clear)
        }
        
        let url: URL? = item.getImageUrl()
        if url != nil {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
}
