//
//  CategoryModel.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 4/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct CategoryModel {
    let name: String
    let number: String
    var subcategories: [CategoryModel]
    let isLeaf: Bool
}

extension CategoryModel {
    
    init(with model: Category) {
        name = model.name ?? ""
        number = model.number ?? ""
        isLeaf = model.isLeaf ?? true
        subcategories = [CategoryModel]()
        model.subcategories?.map({
            CategoryModel(with: $0)
        }).forEach({
            subcategories.append($0)
        })
    }
    
}
