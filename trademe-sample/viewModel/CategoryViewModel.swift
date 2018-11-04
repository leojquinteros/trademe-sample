//
//  CategoryViewModel.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 4/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct CategoryViewModel {
    let name: String
    let number: String
    var subcategories: [CategoryViewModel]
    let isLeaf: Bool
    
    init(with model: Category) {
        name = model.name ?? ""
        number = model.number ?? ""
        isLeaf = model.isLeaf ?? false
        subcategories = [CategoryViewModel]()
        model.subcategories?.map({
            CategoryViewModel(with: $0)
        }).forEach({
            subcategories.append($0)
        })
    }
    
}
