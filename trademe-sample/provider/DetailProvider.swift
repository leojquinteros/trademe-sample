//
//  DetailProvider.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class DetailProvider {
    
    private let client: TMClient
    
    init(client: TMClient = .shared) {
        self.client = client
    }
    
    func retrieve(_ listingID: Int, callback: @escaping (Result<DetailModel, String>) -> Void) {
        
        let endpoint = ListingDetails.retrieve(id: listingID, type: .JSON)
        
        client.detail(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let detail):
                    let listingDetail = DetailModel(with: detail)
                    callback(Result.success(listingDetail))
                    break
                case .failure(let error):
                    callback(Result.failure(error))
                    break
                }
            })
        }
    }
    
}
