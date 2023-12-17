//
//  Search.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum SearchParams {
    static let ROWS = "rows"
    static let CATEGORY = "category"
    static let SEARCH_STRING = "search_string"
}

enum Search {
    case general(rows: Int, category: String, keyword: String, type: ResponseType)
}

extension Search: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    var path: String {
        switch self {
        case .general(_, _, _, let type):
            return "Search/General\(type.rawValue)"
        }
    }
    var httpMethod: HTTPMethod {
        .GET
    }
    var headers: HTTPHeaders? {
        [
            "Content-Type": "application/json",
            "Authorization": AUTHORIZATION_HEADER
        ]
    }
    var task: HTTPTask {
        switch self {
        case .general(let rows, let category, let keyword, _):
            let params: Parameters = [
                SearchParams.ROWS: rows,
                SearchParams.CATEGORY: category,
                SearchParams.SEARCH_STRING: keyword
            ]
            return .requestParameters(params, encoding: .urlEncoding)
        }
    }
    
}
