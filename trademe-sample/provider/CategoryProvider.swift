//
//  CategoryProvider.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class CategoryProvider {
    
    private let client: TMClient
    
    init(client: TMClient = .shared) {
        self.client = client
    }
    
    func retrieve(callback: @escaping (Result<[CategoryModel], String>) -> Void) {
        
        let endpoint = Categories.general(id: 0, type: .JSON)
        
        client.categories(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let categories):
                    let categoryViewModel = CategoryModel(with: categories)
                    callback(Result.success(categoryViewModel.subcategories))
                    break
                case .failure(let error):
                    callback(Result.failure(error))
                    break
                }
            })
        }
    }
}
