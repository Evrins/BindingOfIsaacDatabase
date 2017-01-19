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
import Kingfisher
import SnapKit
import SwifterSwift

private let reuseIdentifier = "Cell"

enum Titles {
    static let Search = "Search"
    static let Items = "Items"
    static let Trinkets = "Trinkets"
    static let CardsAndRunes = "Cards and Runes"
    static let Pickups = "Pickups"
    static let Pills = "Pills"
    static let Settings = "Settings"
}

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var layoutType = LayoutMachine.Grid {
        didSet {
            displayOptions(layoutType: layoutType)
        }
    }
    
    func displayOptions(layoutType: LayoutMachine) {
        switch layoutType {
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
    let menuItemCollection = MenuItemCollection.sharedInstance
    let filterCollection = FilterCollection.sharedInstance
    
    var items: Results<ItemModel>!
    var searchItems: Results<ItemModel>!
    var selectedItem: ItemModel? = nil
    
    let gridFlowLayout = GridFlowLayout()
    let listFlowLayout = ListFlowLayout()
    
    let placeholderView = PlaceHolderView()
    
    var layoutButton: UIButton = {
        let button = UIButton(type: .system)
        //@TODO: Uncommit this
//        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    var currentTitle: String = {
        var title = "Search"
        let activeMenuItemTitle = MenuItemCollection.sharedInstance.getActive().title
        if !activeMenuItemTitle.isEmpty {
            title = MenuItemCollection.sharedInstance.getActive().title
        }
        return title
    }()
    
    var isSearchView = false {
        didSet {
            switch(isSearchView) {
            case true:
                addInSearchBar()
            case false:
                removeSearchBar()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        itemCollection.onComplete = { _ in
            self.items = self.itemCollection.getItems().sorted(byProperty: Filters.ItemAttribute.ItemId, ascending: true)
            self.searchItems = self.items
            self.collectionView.reloadData()
            self.placeholderViewCheck()
            
            self.placeholderView.setPlaceholderLabelText()
        }
        
        menuItemCollection.setActive = { _ in
            self.currentTitle = self.menuItemCollection.getActive().title
            self.placeholderViewCheck()
            self.clearSearchBar()
            
            self.isSearchView = false
            if self.currentTitle == Titles.Search {
                self.isSearchView = true
            }
            
            self.layoutCheck()
            self.setUpSearchBar()
            self.setupBarButtonItems()
        }
        
        itemCollection.loadItems()
        menuItemCollection.loadMenuItems()
        filterCollection.loadFilterModels() { _ -> Void in }

        self.setUpSideMenu()
      
        self.setupConstraints()
        
        displayOptions(layoutType: layoutType)
        collectionView.backgroundColor = UIColor(hex: 0xEAEAEA)
        
        // Register Custom Cells
        collectionView.register(ItemListCollectionViewCell.cellNib, forCellWithReuseIdentifier:ItemListCollectionViewCell.id)
        collectionView.register(ItemCollectionViewCell.cellNib, forCellWithReuseIdentifier:ItemCollectionViewCell.id)
        
        self.setUpSearchBar()
        self.setupBarButtonItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutCheck() {
        switch (currentTitle) {
        case Titles.Search :
            layoutType = .Grid
        case Titles.Items :
            layoutType = .Grid
        case Titles.Trinkets :
            layoutType = .List
        case Titles.CardsAndRunes :
            layoutType = .List
        case Titles.Pickups :
            layoutType = .List
        case Titles.Pills :
            layoutType = .List
        case Titles.Settings :
            layoutType = .Grid
        default:
            print("default case called")
        }
    }
    
    func placeholderViewCheck() {
        self.placeholderView.isHidden = true
        
        if currentTitle == Titles.Search || currentTitle == Titles.Settings || searchItems.isEmpty {
            self.placeholderView.isHidden = false
        }
    }
    
    func menuButtonPressed() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
        handleTap()
    }
    
    func layoutButtonTapped() {
        layoutType.next()
        setupBarButtonItems()
        handleTap()
    }
    
    // MARK: - Private methods
    fileprivate func setupListLayout() {
        collectionView.collectionViewLayout = listFlowLayout
        collectionView.reloadData()
    }
    
    fileprivate func setupGridLayout() {
        collectionView.collectionViewLayout = gridFlowLayout
        collectionView.reloadData()
    }
    
    func setupConstraints() {
        view.addSubview(placeholderView)
        
        searchBar.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        placeholderView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(collectionView.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.bottom)
        }
    }

    func setupBarButtonItems() {
        self.navigationItem.titleView = CustomTitleView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonPressed))
        
        var layoutBarButton = UIBarButtonItem()
        var searchButton = UIBarButtonItem()
        
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.toggleSearchBar))
        
        layoutButton.addTarget(self, action: #selector(self.layoutButtonTapped), for: .touchUpInside)

        switch(layoutType) {
        case .Grid:
            if self.layoutButton.alpha != 1 {
                self.layoutButton.alpha = 0
            }
                
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.layoutButton.alpha = 1
                self.layoutButton.setImage(UIImage(named: "ListItem"), for: .normal)
            }, completion: nil)
        case .List:
            if self.layoutButton.alpha != 1 {
                self.layoutButton.alpha = 0
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.layoutButton.alpha = 1
                self.layoutButton.setImage(UIImage(named: "GridItem"), for: .normal)
            }, completion: nil)
        }
        
        layoutBarButton = UIBarButtonItem(customView: layoutButton)
        
        if self.title != "Items" {
            searchButton = UIBarButtonItem()
        }
        
        navigationItem.rightBarButtonItems = [layoutBarButton, searchButton]
    }
}

extension ItemViewController {
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if items != nil && searchItems != nil {
            return searchItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch(layoutType) {
        case .List:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCollectionViewCell.id, for: indexPath) as! ItemListCollectionViewCell
            
            return cell
        default: // .Grid
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let item = searchItems[indexPath.row]
        let url: URL? = item.getImageUrl()
        
        switch(layoutType) {
        case .List:
            let cell: ItemListCollectionViewCell = cell as! ItemListCollectionViewCell

            
            if let itemQuote = item.getItemQuote(), item.getItemQuote() != nil {
                cell.itemQuote.text = "\"\(itemQuote)\""
            }
            
            if item.getItemQuote() == nil && item.getItemDescription() != nil {
                cell.itemQuote.text = "\(item.getItemDescription()!)"
            }
            
            cell.itemTitle.text = item.getItemName()
            
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            
            if url != nil {
                cell.itemImage.kf.indicatorType = .activity
                cell.itemImage.kf.setImage(with: url)
            }
            
        default: // .Grid
            let cell: ItemCollectionViewCell = cell as! ItemCollectionViewCell
            
            cell.itemTitle.text = ""
            
            cell.itemImage.layer.magnificationFilter = kCAFilterNearest
            
            if url != nil {
                cell.itemImage.kf.indicatorType = .activity
                cell.itemImage.kf.setImage(with: url)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchItems[indexPath.row]
        selectedItem = item
//        performSegue(withIdentifier: "showItemDetail", sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController {
            
            vc.selectedItem = selectedItem
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showItemDetail" {
//            let destinationVC =  segue.destination as! ItemDetailViewController
//            destinationVC.selectedItem = selectedItem
//        }
//    }
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
    
    // MARK: Search bar
    
    func setUpSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor(hex: 0xEAEAEA)
        searchBar.backgroundImage = UIImage()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            placeholderViewCheck()
            
            searchItems = items
        } else {
            placeholderView.isHidden = true
            if searchItems.isEmpty {
                placeholderView.isHidden = false
            }
            
            let newSearchText = searchText.lowercased()
            
            var subPredicates = [NSPredicate]()
            
            for attribute in Filters.ItemAttribute.searchValues {
                let predicate = NSPredicate(format: "%K contains[C] %@", attribute, newSearchText)
                subPredicates.append(predicate)
            }
        
            let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: subPredicates)
            
            searchItems = items.filter(compoundPredicate)
            
        }
        
        placeholderView.searchText = searchText
        collectionView.reloadData()
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
    
    func toggleSearchBar() {
        if searchBar.isHidden {
            addInSearchBar()
            return
        }
        
        if currentTitle != Titles.Search {
            removeSearchBar()
        }
    }
    
    func addInSearchBar() {
        searchBar.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        handleTap()
        searchBar.isHidden = false
    }
    
    func removeSearchBar() {
        searchBar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.top)
        }
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        handleTap()
        searchBar.isHidden = true
    }
    
    func clearSearchBar() {
        searchBar.text = ""
        searchBar(searchBar, textDidChange: "")
    }
}

extension ItemViewController {
    // MARK: Side Menu
    func setUpSideMenu() {
    // Define the menus
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController

        menuLeftNavigationController?.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationBackgroundColor = UIColor.clear
                
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
