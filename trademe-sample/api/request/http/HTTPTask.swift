//
//  HTTPTask.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 21/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(_ params: Parameters?, encoding: ParameterEncoding)
}
