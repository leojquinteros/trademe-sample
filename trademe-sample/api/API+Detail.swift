//
//  API+Detail.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct ListingDetail: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let hasGallery: Bool?
    
    enum CodingKeys : String, CodingKey {
        case id = "ListingId"
        case title = "Title"
        case description = "Body"
        case hasGallery = "HasGallery"
    }
    
}

extension API {
    
    func detail(_ listingID: Int, callback: ((ListingDetail) -> Void)?, onError: ((String) -> Void)?) {
        let url = ENDPOINT + String(format: URI.LISTING_DETAILS.value, arguments: [listingID])
        guard let request = buildRequest(for: url, httpMethod: .GET) else { return }
        perform(request, callback: callback, onError: onError)
    }
    
}
