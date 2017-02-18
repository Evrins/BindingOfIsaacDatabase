//
//  GridLayout.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 2/17/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    
    private let kLazyLoadScreenSize = UIScreen.main.bounds.width
    private let kLazyLoadSpan: CGFloat = 2.0
    private let kLazyLoadAspectRatio: CGFloat = 1 // width / height aspect ratio for non square cells.
    private let kLazyLoadColumnsPerRow: CGFloat = 8.0 // number of columns for every row.
    
    func setupLayout() {
        let width = (kLazyLoadScreenSize - (CGFloat(kLazyLoadColumnsPerRow + 1.0) * kLazyLoadSpan)) / CGFloat(kLazyLoadColumnsPerRow) - 1
        let height = width * kLazyLoadAspectRatio
        
        itemSize = CGSize(width: width, height: height)
        
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
