//
//  DetailViewModel.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

struct DetailViewModel {
    let id: String
    let title: String
    let description: String
    let photoID: Int
    let pictureURL: String
    
    init(with model: ListingDetail) {
        id = "Listing #\(model.id ?? 0)"
        title = model.title ?? ""
        description = model.description ?? ""
        photoID = model.photoID ?? 0
        let photos = model.photos?.filter({ model.photoID == $0.id })
        pictureURL = photos?.first?.value?.gallery ?? ""
    }
    
}
