//
//  API.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

let ENDPOINT = "https://api.tmsandbox.co.nz/v1"

private let CONSUMER_KEY = "A1AC63F0332A131A78FAC304D007E7D1"
private let CONSUMER_SIGNATURE = "EC7F18B17A062962C6930A8AE88B16C7" + "%26"

enum HTTPMethod: String {
    case GET = "GET"
}

enum URI: String {
    case CATEGORIES = "/Categories/0.json"
    case SEARCH = "/Search/General.json?category=%@&rows=20"
    case LISTING_DETAILS = "/Listings/%@.json"
    var value: String {
        return rawValue
    }
}

struct ErrorResponse: Decodable {
    let request: String?
    let description: String?
    
    enum CodingKeys : String, CodingKey {
        case request = "Request"
        case description = "ErrorDescription"
    }
}

class API {
    
    static let shared = API()
    
    func buildRequest(for url: String, httpMethod: HTTPMethod, authorized: Bool = false) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if authorized {
            let oauth = String(format: "OAuth oauth_consumer_key=%@, oauth_signature_method=PLAINTEXT, oauth_signature=%@", arguments: [CONSUMER_KEY, CONSUMER_SIGNATURE])
            request.addValue(oauth, forHTTPHeaderField: "Authorization")
        }
        return request
    }

    func perform<T: Decodable> (_ request: URLRequest, callback: ((T) -> Void)?, onError: ((String) -> Void)?) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse  else { return }
            do {
                switch httpResponse.statusCode {
                case 200..<300:
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    if let callback = callback {
                        callback(responseData)
                    }
                default:
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    if let onError = onError {
                        onError(errorResponse.description ?? "Internal server error")
                    }
                }
            } catch let err {
                print("Error deserializing JSON", err)
            }
        }.resume()
    }

}
