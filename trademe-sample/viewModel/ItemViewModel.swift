//
//  ItemViewModel.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 4/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

struct ItemViewModel {
    let id: Int?
    let title: String?
    let region: String?
    let startPrice: Float?
    let buyNowPrice: Float?
    let hasBuyNow: Bool?
    let reserveState: Int?
    let pictureURL: String?
    
    init(with model: Item) {
        self.id = model.id
        self.title = model.title
        self.region = model.region
        self.startPrice = model.startPrice
        self.buyNowPrice = model.buyNowPrice
        self.reserveState = model.reserveState
        self.pictureURL = model.pictureURL
        self.hasBuyNow = model.hasBuyNow
    }
    
    static func initialize(with model: SearchResponse?) -> [ItemViewModel] {
        guard let model, let models = model.items else { return [] }
        var items = [ItemViewModel]()
        models.map({
            ItemViewModel(with: $0)
        }).forEach({
            items.append($0)
        })
        return items
    }
    
}

extension ItemViewModel {
    var reserveStateText: String? {
        let rsMap = [
            0: "No reserve",
            1: "Reserve met",
            2: "Reserve not met",
            3: "Not applicable"
        ]
        return rsMap[reserveState ?? 3]
    }
    
    var startPriceText: String {
        guard let startPrice else { return "" }
        return "$\(startPrice)"
    }
    
    var buyNowPriceText: String {
        guard let buyNowPrice else { return "" }
        return "$\(buyNowPrice)"
    }
    
    var buyNowText: String {
        hasBuyNow ?? false ? "Buy Now" : ""
    }
    
}
