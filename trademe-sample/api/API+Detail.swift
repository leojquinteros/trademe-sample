//
//  API+Detail.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct PhotoCollection: Decodable {
    let gallery: String?
    let thumbnail: String?
    
    enum CodingKeys : String, CodingKey {
        case gallery = "Gallery"
        case thumbnail = "Thumbnail"
    }
}

struct Photo: Decodable {
    let id: Int?
    let value: PhotoCollection?
    
    enum CodingKeys : String, CodingKey {
        case id = "Key"
        case value = "Value"

    }
}

struct ListingDetail: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let photoID: Int?
    let photos: [Photo]?
    
    enum CodingKeys : String, CodingKey {
        case id = "ListingId"
        case title = "Title"
        case description = "Body"
        case photoID = "PhotoId"
        case photos = "Photos"
    }
}

extension API {
    
    func detail(_ listingID: Int, callback: ((ListingDetail) -> Void)?, onError: ((String) -> Void)?) {
        let url = ENDPOINT + String(format: URI.LISTING_DETAILS.value, arguments: [listingID])
        guard let request = buildRequest(for: url, httpMethod: .GET, authorized: true) else { return }
        perform(request, callback: callback, onError: onError)
    }
    
}
