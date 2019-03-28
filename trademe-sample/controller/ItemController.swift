//
//  ItemController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ItemController: UITableViewController {
    
    var category: CategoryViewModel? {
        didSet {
            title = category?.name
        }
    }
    
    fileprivate var items = [ItemViewModel]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
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
        guard let categoryID = category?.number else { return }
        fetchItems(categoryID, searchController.searchBar.text ?? "")
    }
    
    // MARK: - Refresh control
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.Custom.Foreground.tint
        tableView.addSubview(refreshControl)
    }
    
    @objc fileprivate func handleRefresh(refreshControl: UIRefreshControl) {
        guard let categoryID = category?.number else { return }
        refreshControl.beginRefreshing()
        fetchItems(categoryID, searchController.searchBar.text ?? "")
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
    
    // MARK: - Fetch items
    
    private func fetchItems(_ categoryID: String, _ keyword: String) {
        ItemService().search(categoryID, keyword: keyword) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.items = items
                self?.tableView.reloadData()
                items.count == 0 ? self?.showEmptyTableMessage("No listings to show") : self?.hideEmptyTableMessage()
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true)
                break
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: ItemTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ListingDetailController()
        detailVC.listingID = items[indexPath.row].id
        navigationController?.pushViewController(detailVC, animated: true)
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
