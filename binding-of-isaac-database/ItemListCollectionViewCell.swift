//
//  ItemListCollectionViewCell.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/21/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell, CellInterface {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemQuote: UILabel!

}
