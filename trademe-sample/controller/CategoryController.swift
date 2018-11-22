//
//  CategoryController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit
import ABLoaderView

private let cellID = "cellID"

class CategoryController: UITableViewController {
    
    var name: String?
    var categories = [CategoryViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupTableView()
        retrieveCategories()
        setupNavBar()
    }
    
    fileprivate func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    fileprivate func retrieveCategories() {
        if categories.count > 0 {
            return
        }
        ABLoader().startShining(tableView)
        CategoryService().retrieve { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                if categories.count > 0 {
                    self?.tableView.reloadData()
                } else {
                    self?.showEmptyTableMessage("No categories to show")
                }
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true, completion: nil)
                break
            }
            if let tableView = self?.tableView {
                ABLoader().stopShining(tableView)
            }
        }
    }
    
    private func setupNavBar() {
        title = name ?? "Categories"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let titleTintColor = UIColor.Custom.NavBar.foreground
        navigationController?.navigationBar.tintColor = titleTintColor
        navigationController?.navigationBar.barTintColor = UIColor.Custom.NavBar.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTintColor]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        if !category.isLeaf {
            self.name = category.name
            self.categories = category.subcategories
            tableView.reloadData()
        }
        let itemVC = ItemController()
        itemVC.categoryName = category.name
        itemVC.categoryNumber = category.number
        splitViewController?.showDetailViewController(itemVC, sender: self)
    }
 
}
