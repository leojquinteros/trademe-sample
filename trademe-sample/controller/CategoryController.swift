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
    
    var categories = [CategoryViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        retrieveCategories()
        setupNavBar()
    }
    
    fileprivate func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    fileprivate func retrieveCategories() {
        ABLoader().startShining(tableView)
        CategoryService().retrieve { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true)
                break
            }
            if let tableView = self?.tableView {
                ABLoader().stopShining(tableView)
            }
        }
    }
    
    private func setupNavBar() {
        title = "Main categories"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let titleTintColor = UIColor.Custom.NavBar.foreground
        navigationController?.navigationBar.tintColor = titleTintColor
        navigationController?.navigationBar.barTintColor = UIColor.Custom.NavBar.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTintColor]
    }
}

// MARK: - Table view data source

extension CategoryController {

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
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let itemViewController = ItemController(collectionViewLayout: layout)
        itemViewController.category = categories[indexPath.row]
        navigationController?.pushViewController(itemViewController, animated: true)
    }
 
}
