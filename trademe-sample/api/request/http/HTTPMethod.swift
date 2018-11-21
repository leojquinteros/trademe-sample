//
//  HTTPMethod.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 21/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

enum ResponseType: String {
    case XML = ".xml"
    case JSON = ".json"
}
