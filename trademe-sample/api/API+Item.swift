//
//  API+Item.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let items: [Item]?
    enum CodingKeys : String, CodingKey {
        case items = "List"
    }
}

struct Item: Decodable {
    let id: Int?
    let title: String?
    let region: String?
    let startPrice: Float?
    let buyNowPrice: Float?
    let hasBuyNow: Bool?
    let reserveState: Int?
    let pictureURL: String?
    
    enum CodingKeys : String, CodingKey {
        case id = "ListingId"
        case title = "Title"
        case region = "Region"
        case startPrice = "StartPrice"
        case buyNowPrice = "BuyNowPrice"
        case hasBuyNow = "HasBuyNow"
        case reserveState = "ReserveState"
        case pictureURL = "PictureHref"
    }
    
}

extension API {
    
    func items(_ category: String, callback: ((SearchResponse) -> Void)?, onError: ((String) -> Void)?) {
        let url = ENDPOINT + String(format: URI.SEARCH.value, arguments: [category])
        guard let request = buildRequest(for: url, httpMethod: .GET, authorized: true) else { return }
        perform(request, callback: callback, onError: onError)
    }
    
}
