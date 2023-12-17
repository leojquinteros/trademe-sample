//
//  Router.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 21/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

public typealias RouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
    func request(_ route: Endpoint, completion: @escaping RouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func request(_ route: Endpoint, completion: @escaping RouterCompletion) {
        do {
            let request = try buildRequest(from: route)
            task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path))
        request.httpMethod = route.httpMethod.rawValue
        addHeaders(&request, route.headers)
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let params, let encoding):
                try encoding.encode(urlRequest: &request, bodyParameters: nil, urlParameters: params)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func addHeaders(_ request: inout URLRequest, _ headers: HTTPHeaders?) {
        guard let headers  else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
