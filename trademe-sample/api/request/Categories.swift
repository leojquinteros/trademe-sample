//
//  Categories.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum Categories {
    case general(id: Int, type: ResponseType)
}

extension Categories: Endpoint {

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    var path: String {
        switch self {
            case .general(let id, let type):
                return "Categories/\(id)\(type.rawValue)"
        }
    }
    var httpMethod: HTTPMethod {
        return .GET
    }
    var headers: HTTPHeaders? {
        return nil
    }
    var task: HTTPTask {
        return .request
    }
    
}
