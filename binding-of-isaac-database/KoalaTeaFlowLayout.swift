//
//  KoalaTeaFlowLayout.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 2/18/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import UIKit

class KoalaTeaFlowLayout: UICollectionViewFlowLayout {
    
    private var ratio: CGFloat = 1.0
    private var topBottomMargin: CGFloat = 0
    private var leftRightMargin: CGFloat = 0
    private var cellsAcross: CGFloat = 1
    private var cellSpacing: CGFloat = 0
    private var collectionViewWidth: CGFloat = UIScreen.main.bounds.width
    
    override init() {
        super.init()
//        setupLayout()
    }
    
    convenience init(ratio: CGFloat, topBottomMargin: CGFloat, leftRightMargin: CGFloat, cellsAcross: CGFloat, cellSpacing: CGFloat, collectionViewWidth: CGFloat) {
        self.init()
        setupLayout(ratio: ratio, topBottomMargin: topBottomMargin, leftRightMargin: leftRightMargin, cellsAcross: cellsAcross, cellSpacing: cellSpacing, collectionViewWidth: collectionViewWidth)
    }
    
    convenience init(ratio: CGFloat, topBottomMargin: CGFloat, leftRightMargin: CGFloat, cellsAcross: CGFloat, cellSpacing: CGFloat) {
        self.init()
        setupLayout(ratio: ratio, topBottomMargin: topBottomMargin, leftRightMargin: leftRightMargin, cellsAcross: cellsAcross, cellSpacing: cellSpacing, collectionViewWidth: self.collectionViewWidth)
    }
    
    convenience init(ratio: CGFloat, cellsAcross: CGFloat, cellSpacing: CGFloat) {
        self.init()
        setupLayout(ratio: ratio, topBottomMargin: self.topBottomMargin, leftRightMargin: self.leftRightMargin, cellsAcross: cellsAcross, cellSpacing: cellSpacing, collectionViewWidth: self.collectionViewWidth)
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    ratio = 1.0
//    leftRightMargin = 5
//    cellsAcross = 8
//    cellSpacing = 4
//    collectionViewWidth = UIScreen.main.bounds.width
    
    func setupLayout(ratio: CGFloat, topBottomMargin: CGFloat, leftRightMargin: CGFloat, cellsAcross: CGFloat, cellSpacing: CGFloat, collectionViewWidth: CGFloat) {
        self.ratio = ratio
        self.topBottomMargin = topBottomMargin
        self.leftRightMargin = leftRightMargin
        self.cellsAcross = cellsAcross
        self.cellSpacing = cellSpacing
        self.collectionViewWidth = collectionViewWidth
        
        let spaceBetweenCells = cellSpacing * (cellsAcross - 1)
        let width = (collectionViewWidth - leftRightMargin - spaceBetweenCells) / cellsAcross - 1
        let height = width * ratio
        let calculatedItemSize = CGSize(width: width, height: height)
        
        itemSize = calculatedItemSize
        
        sectionInset = UIEdgeInsets(top: 5, left: leftRightMargin, bottom: 5, right: leftRightMargin)
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
