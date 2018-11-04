//
//  API+Category.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let name: String?
    let number: String?
    let subcategories: [Category]?
    let isLeaf: Bool?
    
    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case number = "Number"
        case subcategories = "Subcategories"
        case isLeaf = "IsLeaf"
    }
}

extension API {
    
    func categories(callback: ((Category) -> Void)?, onError: ((String) -> Void)?) {
        let url = ENDPOINT + URI.CATEGORIES.value
        guard let request = buildRequest(for: url, httpMethod: .GET) else { return }
        perform(request, callback: callback, onError: onError)
    }
    
}
