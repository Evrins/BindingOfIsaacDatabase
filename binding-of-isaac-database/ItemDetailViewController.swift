//
//  ItemDetailViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/24/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemQuoteLabel: UILabel!
    
    var selectedItem: ItemModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        
        itemTitleLabel.text = selectedItem?.getItemName()
        itemQuoteLabel.text = selectedItem?.getItemQuote()
        
        itemImage.layer.magnificationFilter = kCAFilterNearest;
        let image: UIImage? = UIImage(named: (selectedItem?.getItemId()!)!)
        if image != nil {
            itemImage.image = image
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
