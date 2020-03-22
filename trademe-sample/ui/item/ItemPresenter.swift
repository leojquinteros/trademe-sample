//
//  ItemPresenter.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 22/03/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import Foundation

protocol ItemView: class {
    func showLoader()
    func hideLoader()
    func showErrorAlert(_ errorDescription: String?)
    func setItems(_ model: [ItemModel]?)
}

class ItemPresenter {
    
    weak var view: ItemView?
    let provider: ItemProvider
    
    init(with view: ItemView, provider: ItemProvider = ItemProvider()) {
        self.view = view
        self.provider = provider
    }
    
    func getItems(withCategoryID categoryID: String, keyword: String) {
        view?.showLoader()
        ItemProvider().search(categoryID, keyword: keyword) { [weak self] result in
            guard let self = self, let view = self.view else { return }
            switch result {
            case .success(let items):
                view.setItems(items)
                break
            case .failure(let error):
                view.showErrorAlert(error)
                break
            }
            view.hideLoader()
        }
    }
}

