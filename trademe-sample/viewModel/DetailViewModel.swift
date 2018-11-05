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
        id = "#\(model.id ?? 0)"
        title = model.title ?? ""
        description = model.description ?? ""
        photoID = model.photoID ?? 0
        let photos = model.photos?.filter({ model.photoID == $0.id })
        pictureURL = photos?.first?.value?.gallery ?? ""
    }
    
}

extension DetailViewModel {
    
    var listingPicture: UIImage? {
        if let url = URL(string: pictureURL) {
            do {
                let data = try Data(contentsOf : url)
                return UIImage(data : data)
            } catch let err {
                print(err)
            }
        }
        return UIImage()
    }
}
