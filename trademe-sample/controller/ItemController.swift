//
//  ItemController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ItemController: UICollectionViewController {
    
    let columnLayout = CustomFlowLayout(
        cellsPerRow: 1,
        minimumInteritemSpacing: 1,
        minimumLineSpacing: 1,
        sectionInset: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    )
    
    var category: CategoryViewModel? {
        didSet {
            title = category?.name
        }
    }
    
    fileprivate var items = [ItemViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupView()
        retrieveItems()
        addRefreshControl()
        setupSearchController()
    }
    
    // MARK: - Register cell
    
    fileprivate func registerCell() {
        let reuseIdentifier = String(describing: ItemCell.self)
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Setup view
    
    fileprivate func setupView() {
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
    }
    
    // MARK: - Retrieve items
    
    fileprivate func retrieveItems() {
        guard let categoryID = category?.number else { return }
        fetchItems(categoryID, searchController.searchBar.text ?? "")
    }
    
    // MARK: - Refresh control setup
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.Custom.Foreground.tint
        collectionView.addSubview(refreshControl)
    }
    
    @objc fileprivate func handleRefresh(refreshControl: UIRefreshControl) {
        guard let categoryID = category?.number else { return }
        refreshControl.beginRefreshing()
        fetchItems(categoryID, searchController.searchBar.text ?? "")
        refreshControl.endRefreshing()
    }
    
    // MARK: - Search Controller setup
    
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by keyword"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Fetch items from API
    
    private func fetchItems(_ categoryID: String, _ keyword: String) {
        ItemService().search(categoryID, keyword: keyword) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.items = items
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true)
                break
            }
        }
    }
    
}

// MARK: - Delegate & Data source

extension ItemController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = String(describing: ItemCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ItemCell else {
            fatalError("Error trying to dequeue resusable cell: \(reuseIdentifier)")
        }
        cell.item = items[indexPath.row]        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = ListingDetailController()
        detailController.listingID = items[indexPath.row].id
        navigationController?.pushViewController(detailController, animated: true)
    }
}

extension ItemController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let selector = #selector(filter(searchBar:))
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: searchController.searchBar)
        perform(selector, with: searchController.searchBar, afterDelay: 0.5)
    }
    
    @objc fileprivate func filter(searchBar: UISearchBar) {
        guard let categoryID = category?.number, let keyword = searchBar.text else { return }
        fetchItems(categoryID, keyword)
    }
    
}
