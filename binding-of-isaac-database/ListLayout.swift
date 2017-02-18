//
//  ListLayout.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 2/17/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit

class ListLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupLayout()
    }
    
    convenience init(inset: CGFloat) {
        self.init()
        leftRightInset = inset // Needs to be equal to any inset in the collectionviews super view
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    
    var leftRightInset = CGFloat(0)
    
    private let kLazyLoadScreenSize = UIScreen.main.bounds.width
    private let kLazyLoadSpan: CGFloat = 10.0
    private let kLazyLoadAspectRatio: CGFloat = 0.2 // width / height aspect ratio for non square cells.
    private let kLazyLoadColumnsPerRow: CGFloat = 1.0 // number of columns for every row.
    
    func setupLayout() {
        let width = (kLazyLoadScreenSize - (CGFloat(kLazyLoadColumnsPerRow + 1.0) * kLazyLoadSpan)) / CGFloat(kLazyLoadColumnsPerRow) - 1
        let height = width * kLazyLoadAspectRatio
        
        itemSize = CGSize(width: width, height: height)
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        sectionHeadersPinToVisibleBounds = true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
