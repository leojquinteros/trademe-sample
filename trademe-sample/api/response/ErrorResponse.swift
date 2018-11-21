//
//  ErrorResponse.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let request: String?
    let description: String?
    
    enum CodingKeys : String, CodingKey {
        case request = "Request"
        case description = "ErrorDescription"
    }
}

enum APIResponse: String {
    case success
    case serverError = "Internal server error"
    case connection = "Please check your network connection."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
