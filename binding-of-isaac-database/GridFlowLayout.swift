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
        let ratio: CGFloat = 1.0
        let leftRightMargin: CGFloat = 5
        let cellsAcross: CGFloat = 8
        let cellSpacing: CGFloat = 4
        let spaceBetweenCells = cellSpacing * (cellsAcross - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - leftRightMargin - spaceBetweenCells) / cellsAcross - 1
        let height = width * ratio
        calculatedItemSize = CGSize(width: width, height: height)
        
        itemSize = calculatedItemSize
        
        sectionInset = UIEdgeInsets(top: 5, left: leftRightMargin, bottom: 5, right: leftRightMargin)
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }

    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
