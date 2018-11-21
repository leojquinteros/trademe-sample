//
//  CategoryService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class CategoryService {

    func retrieve(callback: @escaping (Result<[CategoryViewModel], String>) -> Void) {
        
        let endpoint = Categories.general(id: 0, type: .JSON)
        
        TMClient.shared.categories(endpoint) { result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let categories):
                    let categoryViewModel = CategoryViewModel(with: categories)
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
