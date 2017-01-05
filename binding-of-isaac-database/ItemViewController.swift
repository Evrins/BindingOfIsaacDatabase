//
//  ItemViewController.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/20/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift
import SideMenu

private let reuseIdentifier = "Cell"

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var layoutType = LayoutMachine.Grid {
        didSet {
            displayOptions(layoutType: layoutType)
        }
    }
    
    func displayOptions(layoutType: LayoutMachine) {
        switch layoutType {
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
        
        itemCollection.onComplete = { _ in
            self.items = self.itemCollection.getItems().sorted(byProperty: "itemId", ascending: true)
            self.searchItems = self.items
            self.collectionView.reloadData()
        }

        itemCollection.loadItems()
        self.setUpSideMenu()

        displayOptions(layoutType: layoutType)
        collectionView.backgroundColor = UIColor(hex: 0xEAEAEA)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func menuButtonPressed() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func addTapped() {
        layoutType.next()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        switch(layoutType) {
        case .List:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCollectionViewCell.id, for: indexPath) as! ItemListCollectionViewCell
            
            cell.itemQuote.text = "\"\(item.getItemQuote()!)\""
            cell.itemTitle.text = item.getItemName()
            
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            var image: UIImage? = nil
            if let itemId = item.getItemId() {
                image = UIImage(named: itemId)
            }
            if image != nil {
                cell.itemImage.image = image
            }
            
            cell.alpha = 0
            UIView.animate(withDuration: 0.25, animations: { cell.alpha = 1 })
            
            return cell
        default: // .Grid
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
            
//            cell.itemTitle.text = ""
            cell.itemTitle.text = item.getItemName()
            
            cell.itemImage.backgroundColor = .cyan
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            
            var image: UIImage? = nil
            if let itemId = item.getItemId() {
                image = UIImage(named: itemId)
            }
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

extension ItemViewController {
    func setUpSideMenu() {
    // Define the menus
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController

        menuLeftNavigationController?.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationBackgroundColor = UIColor.clear
        
        let menuRightNavigationController = UISideMenuNavigationController()
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuRightNavigationController = menuRightNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
