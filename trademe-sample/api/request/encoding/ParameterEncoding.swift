//
//  ParameterEncoding.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 21/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

public enum EncoderError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        do {
            switch self {
                case .urlEncoding:
                    guard let urlParameters  else { return }
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)

                case .jsonEncoding:
                    guard let bodyParameters  else { return }
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
                case .urlAndJsonEncoding:
                    guard let bodyParameters, let urlParameters else { return }
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}
