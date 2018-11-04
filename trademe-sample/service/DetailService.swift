//
//  DetailService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class DetailService {
    
    func retrieve(_ listingID: Int, callback: ((DetailViewModel) -> Void)?, onError: ((String) -> Void)?) {
        
        API.shared.detail(listingID, callback: { (response) in
            let listingDetail = DetailViewModel(with: response)
            callback?(listingDetail)
        }) { (message) in
            onError?(message)
        }
    }
    
}
