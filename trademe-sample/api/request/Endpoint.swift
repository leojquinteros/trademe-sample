//
//  Endpoint.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}

extension Endpoint {
    
    var environmentBaseURL : String {
        switch TMClient.environment {
        case .sandbox: return "https://api.tmsandbox.co.nz/v1"
        case .production: return "https://api.trademe.co.nz/v1"
        }
    }
    var OAUTH_HEADER_FORMAT: String {
        return "OAuth oauth_consumer_key=%@, oauth_signature_method=PLAINTEXT, oauth_signature=%@"
    }
    var CONSUMER_KEY: String {
        return "A1AC63F0332A131A78FAC304D007E7D1"
    }
    var CONSUMER_SIGNATURE: String {
        return "EC7F18B17A062962C6930A8AE88B16C7" + "%26"
    }
    var AUTHORIZATION_HEADER: String {
        return String(format: OAUTH_HEADER_FORMAT, arguments: [CONSUMER_KEY, CONSUMER_SIGNATURE])
    }
    
}
