//
//  ItemProvider.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class ItemProvider {
    
    private let client: TMClient
    
    init(client: TMClient = .shared) {
        self.client = client
    }
    
    func search(_ categoryID: String, keyword: String = "", callback: @escaping (Result<[ItemModel], String>) -> Void) {
        
        let endpoint = Search.general(rows: 20, category: categoryID, keyword: keyword, type: .JSON)
        
        client.search(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let items):
                    let itemsViewModel = ItemModel.initialize(with: items)
                    callback(Result.success(itemsViewModel))
                    break
                case .failure(let error):
                    callback(Result.failure(error))
                    break
                }
            })
        }
    }
    
}
