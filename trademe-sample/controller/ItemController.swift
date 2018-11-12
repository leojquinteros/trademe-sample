//
//  ItemController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ItemController: UITableViewController {
    
    var categoryNumber: String?
    var items = [ItemViewModel]()
    var filteredItems = [ItemViewModel]()
    var searchController = UISearchController(searchResultsController: nil)
    let itemService = ItemService()
    
    var categoryName: String? {
        didSet {
            title = categoryName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupTableView()
        retrieveItems()
        addRefreshControl()
        setupSearchController()
    }
    
    fileprivate func registerCell() {
        let reuseIdentifier = String(describing: ItemTableViewCell.self)
        let itemCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    fileprivate func setupTableView() {
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    fileprivate func retrieveItems() {
        guard let categoryID = categoryNumber else { return }
        itemService.retrieve(categoryID, callback: { [weak self] (items) in
            if items.count > 0 {
                self?.items = items
                DispatchQueue.main.async(execute: {
                    self?.tableView.reloadData()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    self?.showEmptyTableMessage("No items to show in the selected category")
                })
            }
            
        }) { [weak self] (errorMessage) in
            DispatchQueue.main.async(execute: {
                self?.present(UIAlertController.error(withMessage: errorMessage), animated: true, completion: nil)
            })
        }
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.Custom.Foreground.tint
        tableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefresh(refreshControl: UIRefreshControl) {
//        guard let categoryID = categoryNumber else { return }
//        itemService.retrieve(categoryID, callback: { [weak self] (items) in
//            if items.count > 0 {
//                self?.items = items
//                DispatchQueue.main.async(execute: {
//                    self?.tableView.reloadData()
//                    refreshControl.endRefreshing()
//                })
//            } else {
//                DispatchQueue.main.async(execute: {
//                    self?.showEmptyTableMessage("No items to show in the selected category")
//                    refreshControl.endRefreshing()
//                })
//            }
//        }) { [weak self] (errorMessage) in
//            DispatchQueue.main.async(execute: {
//                refreshControl.endRefreshing()
//                self?.present(UIAlertController.error(withMessage: errorMessage), animated: true, completion: nil)
//            })
//        }
        refreshControl.endRefreshing()
    }
    
    // MARK: - Search Controller
    
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by keyword"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func isFiltering() -> Bool {
        return !isSearchBarEmpty() && searchController.isActive
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredItems.count : items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: ItemTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.item = isFiltering() ? filteredItems[indexPath.row] : items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ListingDetailController()
        detailVC.listingID = isFiltering() ? filteredItems[indexPath.row].id : items[indexPath.row].id
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension ItemController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filter(keyword: searchText)
    }
    
    fileprivate func filter(keyword: String) {
        guard let categoryID = categoryNumber else { return }
        itemService.retrieve(categoryID, keyword: keyword, callback: { [weak self] (items) in
            if items.count > 0 {
                self?.filteredItems = items
                DispatchQueue.main.async(execute: {
                    self?.tableView.reloadData()
                })
            }
        }) { [weak self] (errorMessage) in
            DispatchQueue.main.async(execute: {
                self?.present(UIAlertController.error(withMessage: errorMessage), animated: true, completion: nil)
            })
        }
        tableView.reloadData()
    }
}
