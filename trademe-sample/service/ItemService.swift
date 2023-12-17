//
//  ItemService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class ItemService {
    
    func search(_ categoryID: String, keyword: String = "", callback: @escaping (Result<[ItemViewModel], String>) -> Void) {
        
        let endpoint = Search.general(rows: 20, category: categoryID, keyword: keyword, type: .JSON)
        
        TMClient.shared.search(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let items):
                    let itemsViewModel = ItemViewModel.initialize(with: items)
                    callback(Result.success(itemsViewModel))
                case .failure(let error):
                    callback(Result.failure(error))
                }
            })
        }
    }
    
}
