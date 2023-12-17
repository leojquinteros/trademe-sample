//
//  DetailService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class DetailService {
    
    func retrieve(_ listingID: Int, callback: @escaping (Result<DetailViewModel, String>) -> Void) {
        
        let endpoint = ListingDetails.retrieve(id: listingID, type: .JSON)
        
        TMClient.shared.detail(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let detail):
                    let listingDetail = DetailViewModel(with: detail)
                    callback(Result.success(listingDetail))
                case .failure(let error):
                    callback(Result.failure(error))
                }
            })
        }
    }
    
}
