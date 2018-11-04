//
//  CategoryService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class CategoryService {

    func retrieve(callback: (([CategoryViewModel]) -> Void)?, onError: ((String) -> Void)?) {
        
        API.shared.categories(callback: { (response) in
            let category = CategoryViewModel(with: response)
            callback?(category.subcategories)
        }) { (message) in
            onError?(message)
        }
    }

}
