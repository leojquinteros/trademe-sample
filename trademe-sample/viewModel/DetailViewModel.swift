//
//  DetailViewModel.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct DetailViewModel {
    let id: Int
    let title: String
    let description: String
    let hasGallery: Bool
    
    init(with model: ListingDetail) {
        id = model.id ?? 0
        title = model.title ?? ""
        description = model.description ?? ""
        hasGallery = model.hasGallery ?? false
    }
    
}
