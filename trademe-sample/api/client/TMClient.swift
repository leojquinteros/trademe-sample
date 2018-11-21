//
//  TMClient.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 22/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum Environment {
    case sandbox
    case production
}

class TMClient: GenericClient {
    
    static let shared = TMClient()
    static let environment: Environment = .sandbox
    
    func categories(_ endpoint: Endpoint, completion: @escaping APICompletion<Category>) {
        perform(endpoint, completion: completion)
    }
    
    func search(_ endpoint: Endpoint, completion: @escaping APICompletion<SearchResponse>) {
        perform(endpoint, completion: completion)
    }
    
    func detail(_ endpoint: Endpoint, completion: @escaping APICompletion<ListingDetail>) {
        perform(endpoint, completion: completion)
    }
    
}
