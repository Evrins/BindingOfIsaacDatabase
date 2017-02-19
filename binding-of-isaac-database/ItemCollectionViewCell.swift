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
    let imageContentView = UIView()
    
    var checkmarkImageView = UIImageView()
    
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
        checkmarkImageView.snp.remakeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            
            let size = contentView.size.height / 2
            let calculateImageSize = CGSize(width: size, height: size)
            make.size.equalTo(calculateImageSize)
        }
    }
    
    func setupConstraints() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(checkmarkImageView)
        
        contentView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.magnificationFilter = kCAFilterNearest
        
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.layer.magnificationFilter = kCAFilterNearest
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            let inset = 0
            make.edges.equalToSuperview().inset(inset)
        }
        
        checkmarkImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview()

            let size = contentView.size.height / 2
            let calculateImageSize = CGSize(width: size, height: size)
            make.size.equalTo(calculateImageSize)
        }
    }
    
    func setupCell(item: ItemModel) {
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
