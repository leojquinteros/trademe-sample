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
        ItemService().search(categoryID) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.items = items
                if items.count > 0 {
                    self?.tableView.reloadData()
                } else {
                    self?.showEmptyTableMessage("No items to show in the selected category")
                }
                break
            case .failure(let error):
                 self?.present(UIAlertController.error(withMessage: error), animated: true, completion: nil)
                break
            }
        }
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.Custom.Foreground.tint
        tableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefresh(refreshControl: UIRefreshControl) {
        guard let categoryID = categoryNumber else { return }
        let searchText = searchController.searchBar.text ?? ""
        ItemService().search(categoryID, keyword: searchText) { [weak self] (result) in
            switch result {
            case .success(let items):
                if items.count > 0 {
                    if self?.isFiltering() ?? false {
                        self?.filteredItems = items
                    } else {
                        self?.items = items
                    }
                    self?.tableView.reloadData()
                } else {
                    self?.showEmptyTableMessage("No items to show in the selected category")
                }
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true, completion: nil)
                break
            }
            refreshControl.endRefreshing()
        }
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
        ItemService().search(categoryID, keyword: keyword) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.filteredItems = items
                self?.tableView.reloadData()
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true, completion: nil)
                break
            }
        }
    }
}
