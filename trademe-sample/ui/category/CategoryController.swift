//
//  CategoryController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit
import ABLoaderView

class CategoryController: UITableViewController {
    
    var presenter: CategoryPresenter?
    weak var delegate: ItemResultsDelegate?
    
    var categories: [CategoryModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CategoryPresenter(with: self)
        registerCell()
        retrieveCategories()
        setupNavBar()
    }
    
    fileprivate func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    fileprivate func retrieveCategories() {
        if categories == nil {
            presenter?.getCategories()
        }
    }
    
    private func setupNavBar() {
        title = "Categories"
        let titleTintColor = UIColor.Custom.NavBar.foreground
        navigationController?.navigationBar.tintColor = titleTintColor
        navigationController?.navigationBar.barTintColor = UIColor.Custom.NavBar.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTintColor]
    }
}

// MARK: - View Delegate

extension CategoryController: CategoryView {
    
    func showLoader() {
        ABLoader().startShining(tableView)
    }
    
    func hideLoader() {
        ABLoader().stopShining(tableView)
    }
    
    func showErrorAlert(_ errorDescription: String?) {
        present(UIAlertController.error(withMessage: errorDescription), animated: true)
    }
    
    func setCategories(_ model: [CategoryModel]?) {
        self.categories = model
    }

}

// MARK: - Table view data source

extension CategoryController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        let currentCategory = categories[indexPath.row]
        if !currentCategory.isLeaf {
            self.categories = currentCategory.subcategories
            //navigationController?.pushViewController(self, animated: true)
        }
        delegate?.refreshItemResult(categoryID: currentCategory.number)
    }
 
}
