//
//  RequestError.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
            switch self {
            case .decode:
                return "Decode error"
            case .unauthorized:
                return "Session expired"
            default:
                return "Unknown error"
            }
        }
}
