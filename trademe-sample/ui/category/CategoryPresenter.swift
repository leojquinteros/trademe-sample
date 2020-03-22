//
//  CategoryPresenter.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 22/03/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import Foundation

protocol CategoryView: class {
    func showLoader()
    func hideLoader()
    func showErrorAlert(_ errorDescription: String?)
    func setCategories(_ model: [CategoryModel]?)
}

class CategoryPresenter {
    
    weak var view: CategoryView?
    let provider: CategoryProvider
    
    init(with view: CategoryView, provider: CategoryProvider = CategoryProvider()) {
        self.view = view
        self.provider = provider
    }
    
    func getCategories() {
        view?.showLoader()
        CategoryProvider().retrieve { [weak self] result in
            guard let self = self, let view = self.view else { return }
            switch result {
            case .success(let categories):
                view.setCategories(categories)
                break
            case .failure(let error):
                view.showErrorAlert(error)
                break
            }
            view.hideLoader()
        }
    }
}
