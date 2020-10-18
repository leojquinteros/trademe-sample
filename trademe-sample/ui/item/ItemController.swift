//
//  ItemController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit
import ABLoaderView

protocol ItemResultsDelegate: class {
    func refreshItemResult(categoryID: String)
}

class ItemController: UICollectionViewController {
    
    var presenter: ItemPresenter?
    
    var categoryController: CategoryController?

    let columnLayout = CustomFlowLayout(
        cellsPerRow: 1,
        minimumInteritemSpacing: 1,
        minimumLineSpacing: 1,
        sectionInset: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    )
    
    var category: CategoryModel? {
        didSet {
            title = category?.name
        }
    }
    
    fileprivate var items: [ItemModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ItemPresenter(with: self)
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
        let refineButton = UIBarButtonItem(title: "Refine", style: .plain, target: self, action: #selector(refineButtonTapped))
        navigationItem.rightBarButtonItems = [refineButton]
    }
    
    @objc private func refineButtonTapped() {
        if categoryController == nil {
            categoryController = CategoryController()
            categoryController?.delegate = self
        }
        let navController =  UINavigationController(rootViewController:  categoryController!)
        present(navController, animated: true)
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
        let searchKeyword = searchController.searchBar.text ?? ""
        presenter?.getItems(withCategoryID: categoryID, keyword: searchKeyword)
    }
    
}

// MARK: - View Delegate

extension ItemController: ItemView {
    
    func showLoader() {
        ABLoader().startShining(collectionView)
    }
    
    func hideLoader() {
        ABLoader().stopShining(collectionView)
    }
    
    func showErrorAlert(_ errorDescription: String?) {
        present(UIAlertController.error(withMessage: errorDescription), animated: true)
    }
    
    func setItems(_ model: [ItemModel]?) {
        self.items = model
    }
    
}

// MARK: - Collection view delegate & data source

extension ItemController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = String(describing: ItemCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ItemCell else {
            fatalError("Error trying to dequeue resusable cell: \(reuseIdentifier)")
        }
        cell.item = items?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let items = items, let listingID = items[indexPath.row].id {
            let detailController = ListingDetailController(id: listingID)
            navigationController?.pushViewController(detailController, animated: true)
        }
    }
}

extension ItemController: ItemResultsDelegate {
    
    func refreshItemResult(categoryID: String) {
        presenter?.getItems(withCategoryID: categoryID)
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
