//
//  ListFlowLayout.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    
    var calculatedItemSize = CGSize()
    
    override init() {
        super.init()
        setUpListLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpListLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setUpListLayout() {
        let leftRightMargin = CGFloat(10)
        let cellSpacing = CGFloat(5)
        let cellHeight = CGFloat(50)
        let screenWidth = UIScreen.main.bounds.width
        let dim = (screenWidth - leftRightMargin)
        calculatedItemSize = CGSize(width: dim, height: cellHeight)
        
        itemSize = calculatedItemSize
        
        sectionInset = UIEdgeInsets(top: 10, left: leftRightMargin, bottom: 10, right: leftRightMargin)
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
