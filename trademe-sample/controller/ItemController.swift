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
    var categoryName: String? {
        didSet {
            title = categoryName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        retrieveItems()
        addRefreshControl()
    }
    
    fileprivate func registerCell() {
        let reuseIdentifier = String(describing: ItemTableViewCell.self)
        let itemCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
    }
    
    fileprivate func retrieveItems() {
        guard let category = categoryNumber else { return }
        API.shared.items(category, callback: { [weak self] (response) in
            let items = response.items ?? []
            if items.count > 0 {
                self?.items = ItemViewModel.initialize(with: items)
                DispatchQueue.main.async(execute: {
                    self?.tableView.separatorStyle = .singleLine
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
        guard let category = categoryNumber else { return }
        API.shared.items(category, callback: { [weak self] (response) in
            let items = response.items ?? []
            if items.count > 0 {
                self?.items = ItemViewModel.initialize(with: items)
                DispatchQueue.main.async(execute: {
                    self?.tableView.separatorStyle = .singleLine
                    self?.tableView.reloadData()
                    refreshControl.endRefreshing()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    self?.showEmptyTableMessage("No items to show in the selected category")
                    refreshControl.endRefreshing()
                })
            }
        }) { [weak self] (errorMessage) in
            DispatchQueue.main.async(execute: {
                refreshControl.endRefreshing()
                self?.present(UIAlertController.error(withMessage: errorMessage), animated: true, completion: nil)
            })
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count > 0 ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: ItemTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
