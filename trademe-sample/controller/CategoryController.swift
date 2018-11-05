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
        retrieveCategories()
        setupNavBar()
    }
    
    fileprivate func retrieveCategories() {
        if categories.count > 0 {
            return
        }
        ABLoader().startShining(tableView)
        CategoryService().retrieve(callback: { [weak self] (categories) in
            if categories.count > 0 {
                self?.categories = categories
                DispatchQueue.main.async(execute: {
                    if let tableView = self?.tableView {
                        ABLoader().stopShining(tableView)
                    }
                    self?.tableView.reloadData()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    if let tableView = self?.tableView {
                        ABLoader().stopShining(tableView)
                    }
                    self?.showEmptyTableMessage("No categories to show")
                })
            }
        }) { [weak self] (errorMessage) in
            DispatchQueue.main.async(execute: {
                if let tableView = self?.tableView {
                    ABLoader().stopShining(tableView)
                }
                self?.present(UIAlertController.error(withMessage: errorMessage), animated: true, completion: nil)
            })
        }
    }
    
    fileprivate func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    fileprivate func setupNavBar() {
        title = name ?? "Categories"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let titleTintColor = UIColor.Custom.NavBar.foreground
        navigationController?.navigationBar.tintColor = titleTintColor
        navigationController?.navigationBar.barTintColor = UIColor.Custom.NavBar.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTintColor]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count > 0 ? 1 : 0
    }

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
        if (category.isLeaf) {
            let itemVC = ItemController()
            itemVC.categoryName = category.name
            itemVC.categoryNumber = category.number
            navigationController?.pushViewController(itemVC, animated: true)
        } else {
            let categoriesVC = CategoryController()
            categoriesVC.name = category.name
            categoriesVC.categories = category.subcategories
            navigationController?.pushViewController(categoriesVC, animated: true)
        }
        
    }
 
}
