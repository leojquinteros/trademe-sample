//
//  ListingDetailResponse.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

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

struct Photo: Decodable {
    let id: Int?
    let value: PhotoCollection?
    
    enum CodingKeys : String, CodingKey {
        case id = "Key"
        case value = "Value"
    }
}

struct PhotoCollection: Decodable {
    let gallery: String?
    let thumbnail: String?
    
    enum CodingKeys : String, CodingKey {
        case gallery = "Gallery"
        case thumbnail = "Thumbnail"
    }
}
