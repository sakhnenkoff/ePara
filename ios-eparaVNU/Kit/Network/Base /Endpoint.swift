//
//  Endpoint.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

enum RequestMethod: String {
    case delete
    case get
    case patch
    case post
    case put
    
    var name: String {
        return self.rawValue.capitalized
    }
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    
    var parameters: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "http://194.44.187.20/"
    }
}

