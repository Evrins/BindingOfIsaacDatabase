//
//  GridFlowLayout.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    var calculatedItemSize = CGSize()
    
    override init() {
        super.init()
        setupGridLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGridLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupGridLayout() {
        let leftRightMargin = CGFloat(10)
        let cellsAcross: CGFloat = 7 + 1
        let cellSpacing = CGFloat(5)
        let spaceBetweenCells = cellSpacing * (cellsAcross - 1)
        let screenWidth = UIScreen.main.bounds.width
        let dim = (screenWidth - leftRightMargin - spaceBetweenCells) / cellsAcross
        calculatedItemSize = CGSize(width: dim, height: dim)
        
        itemSize = calculatedItemSize
        
        sectionInset = UIEdgeInsets(top: 10, left: leftRightMargin, bottom: 10, right: leftRightMargin)
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }
    
//    override var itemSize: CGSize {
//        set {
//            self.itemSize = calculatedItemSize
//        }
//        get {
//            return calculatedItemSize
//        }
//    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
