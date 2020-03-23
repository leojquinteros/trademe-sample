//
//  ListingDetailPresenter.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 22/03/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import Foundation

protocol ListingDetailView: class {
    func showLoader()
    func hideLoader()
    func showErrorAlert(_ errorDescription: String?)
    func setDetail(_ model: DetailModel?)
}

class ListingDetailPresenter {

    weak var view: ListingDetailView?
    private let id: Int
    private let provider: DetailProvider
    
    init(with view: ListingDetailView, listingID: Int, provider: DetailProvider = DetailProvider()) {
        self.view = view
        self.id = listingID
        self.provider = provider
    }
    
    func getDetail() {
        view?.showLoader()
        DetailProvider().retrieve(id) { [weak self] result in
            guard let self = self, let view = self.view else { return }
            switch result {
            case .success(let detail):
                view.setDetail(detail)
                break
            case .failure(let error):
                view.showErrorAlert(error)
                break
            }
            view.hideLoader()
        }
    }
}
