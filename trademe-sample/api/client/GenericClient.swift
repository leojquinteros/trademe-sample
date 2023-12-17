//
//  GenericClient.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 15/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

enum Result<T, String> {
    case success(T)
    case failure(String)
}

typealias APICompletion<T: Decodable> = (Result<T, String>) -> ()

class GenericClient {
    
    func perform<T: Decodable> (_ endpoint: Endpoint, completion: @escaping APICompletion<T>) {
        
        Router().request(endpoint) { data, response, error in
            
            if let error = error {
                completion(Result.failure(error.localizedDescription))
            }
            if let httpResponse = response as? HTTPURLResponse {
                guard let data else {
                    completion(Result.failure(APIResponse.noData.rawValue))
                    return
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(Result.success(apiResponse))
                    } catch {
                        completion(Result.failure(APIResponse.unableToDecode.rawValue))
                    }
                default:
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(Result.failure(errorResponse.description ?? APIResponse.serverError.rawValue))
                    } catch {
                        completion(Result.failure(APIResponse.unableToDecode.rawValue))
                    }
                }
            }
        }
    }
    
}
