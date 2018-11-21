//
//  ListingDetails.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum ListingDetails {
    case retrieve(id: Int, type: ResponseType)
}

extension ListingDetails: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    var path: String {
        switch self {
            case .retrieve(let id, let type):
                return "Listings/\(id)\(type.rawValue)"
        }
    }
    var httpMethod: HTTPMethod {
        return .GET
    }
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json",
            "Authorization": AUTHORIZATION_HEADER
        ]
    }
    var task: HTTPTask {
        return .request
    }
    
}
