//
//  APITypes.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

// MARK: API Responses

public struct ApiResponse: Codable {
    let export: Export
    
    enum CodingKeys: String, CodingKey {
        case export = "psrozklad_export"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        export = try container.decode(Export.self, forKey: .export)
    }
}

public struct Export: Codable {
    let departments: [Department]?
    
    let code: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMessage = "error_message"
        case departments
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        departments = try container.decodeIfPresent([Department].self, forKey: .departments)
        code = try container.decode(Int.self, forKey: .code)
        errorMessage = try container.decode(String.self, forKey: .errorMessage)
    }
}

// MARK: Faculties & Groups

public struct Department: Codable {
    let name: String
    let objects: [Object]
}

extension Department {
    struct Object: Codable {
        let facultyName: String
        let ID: Int
        
        enum CodingKeys: String, CodingKey {
            case facultyName = "name"
            case ID
        }
    }
}



