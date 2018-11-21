//
//  CategoryResponse.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
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
