//
//  ItemViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ItemCollectionDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var tap: UITapGestureRecognizer!
    
    let itemCollection = ItemCollection.sharedInstance
    var items: Results<ItemModel>!
    var searchItems: Results<ItemModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        itemCollection.delegate = self

        itemCollection.loadItems()
        self.items = self.itemCollection.getItems()
        self.searchItems = items
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func itemsDidFinishLoading() {
        self.items = self.itemCollection.getItems()
        collectionView.reloadData()
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

extension ItemViewController {
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if items != nil {
            return searchItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        // Configure the cell
        cell.itemImage.backgroundColor = UIColor.cyan
        cell.itemTitle.text = searchItems[indexPath.row].getItemName()
        
        return cell
    }
}

extension ItemViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchItems = items
        } else {
            let newSearchText = searchText.lowercased()
            let predicate = NSPredicate(format: "itemName contains[c] '\(newSearchText)'")
            let predicate1 = NSPredicate(format: "itemId contains[c] '\(newSearchText)'")
            let predicate2 = NSPredicate(format: "itemQuote contains[c] '\(newSearchText)'")
            let predicate3 = NSPredicate(format: "itemDescription contains[c] '\(newSearchText)'")
            let predicate4 = NSPredicate(format: "itemType contains[c] '\(newSearchText)'")
            let predicate5 = NSPredicate(format: "itemPool contains[c] '\(newSearchText)'")
            let predicate6 = NSPredicate(format: "itemTags contains[c] '\(newSearchText)'")
            let predicate7 = NSPredicate(format: "rechargeTime contains[c] '\(newSearchText)'")
            
            let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates:
                [
                    predicate,
                    predicate1,
                    predicate2,
                    predicate3,
                    predicate4,
                    predicate5,
                    predicate6,
                    predicate7
                ]
            )
            
            searchItems = items.filter(compoundPredicate)
            
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hi \(indexPath.row)")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tap)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tap)
    }
    
    func handleTap() {
        view.endEditing(true)
    }
    
}
