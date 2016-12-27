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
    
    var genre = LayoutMachine.Grid {
        didSet {
            displayOptions(genre: genre)
        }
    }
    
    func displayOptions(genre: LayoutMachine) {
        switch genre {
//        case .Grid:
//            setupGridLayout()
        case .List:
            setupListLayout()
//        case .Color:
//            displayRockSongs()
        default:
            setupGridLayout()
        }
    }
    
    fileprivate var tap: UITapGestureRecognizer!
    
    let itemCollection = ItemCollection.sharedInstance
    var items: Results<ItemModel>!
    var searchItems: Results<ItemModel>!
    var selectedItem: ItemModel? = nil
    
    let gridFlowLayout = GridFlowLayout()
    let listFlowLayout = ListFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        itemCollection.delegate = self

        itemCollection.loadItems()

        displayOptions(genre: genre)
        collectionView.backgroundColor = UIColor(rgb: 0xEAEAEA)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(addTapped))

    }
    
    func addTapped() {
        genre.next()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func itemsDidFinishLoading() {
        self.items = self.itemCollection.getItemsSorted(byProperty: "itemId")
        self.searchItems = items
        collectionView.reloadData()
    }
    
    // MARK: - Private methods
    fileprivate func setupListLayout() {
        collectionView.register(ItemListCollectionViewCell.cellNib, forCellWithReuseIdentifier:ItemListCollectionViewCell.id)
        collectionView.collectionViewLayout = listFlowLayout
        collectionView.reloadData()
    }
    
    fileprivate func setupGridLayout() {
        collectionView.register(ItemCollectionViewCell.cellNib, forCellWithReuseIdentifier:ItemCollectionViewCell.id)

        collectionView.collectionViewLayout = gridFlowLayout
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
        let item = searchItems[indexPath.row]
        
        switch(genre) {
        case .List:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCollectionViewCell.id, for: indexPath) as! ItemListCollectionViewCell
            
            cell.itemQuote.text = "\"\(item.getItemQuote()!)\""
            cell.itemTitle.text = item.getItemName()
            
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            let image: UIImage? = UIImage(named: item.getItemId()!)
            if image != nil {
                cell.itemImage.image = image
            }
            
            cell.alpha = 0
            UIView.animate(withDuration: 0.25, animations: { cell.alpha = 1 })
            
            return cell
        default: // .Grid
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
            
            cell.itemTitle.text = ""
            
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            let image: UIImage? = UIImage(named: item.getItemId()!)
            if image != nil {
                cell.itemImage.image = image
            }
                        
            cell.alpha = 0
            UIView.animate(withDuration: 0.25, animations: { cell.alpha = 1 })
            
            return cell
        }
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
        let item = searchItems[indexPath.row]
        selectedItem = item
        performSegue(withIdentifier: "showItemDetail", sender: nil)
//        print("Item: \(item.getItemId())")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetail" {
            let destinationVC =  segue.destination as! ItemDetailViewController
            destinationVC.selectedItem = selectedItem
        }

    }
    
}

extension ItemViewController {
    // MARK: - Collection View Delegate Flow Layout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: (bounds.width * 10), height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}
