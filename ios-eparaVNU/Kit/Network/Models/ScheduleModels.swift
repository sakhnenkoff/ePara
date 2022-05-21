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
    let scheduleItems: [ScheduleItem]?
    
    let code: String
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMessage = "error_message"
        case departments = "departments"
        case scheduleItems = "roz_items"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        departments = try container.decodeIfPresent([Department].self, forKey: .departments)
        code = try container.decode(String.self, forKey: .code)
        errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        scheduleItems = try container.decodeIfPresent([ScheduleItem].self, forKey: .scheduleItems)
    }
}

// MARK: Faculties & Groups

public struct Department: Codable {
    let name: String
    let groups: [Group]
    
    enum CodingKeys: String, CodingKey {
        case groups = "objects"
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groups = try container.decode([Group].self, forKey: .groups)
        name = try container.decode(String.self, forKey: .name)
    }
}

extension Department {
    struct Group: Codable {
        let groupName: String
        let ID: String
        
        enum CodingKeys: String, CodingKey {
            case groupName = "name"
            case ID
        }
    }
}

// MARK: ScheduleItem

public struct ScheduleItem: Codable {
    let group: String
    let date: Date?
    let comment: String
    let lessonNumber: String
    let lessonName: String
    let lessonTime: String
    let lessonDescription: String
    
    enum CodingKeys: String, CodingKey {
        case group = "object"
        case date
        case comment
        case lessonNumber = "lesson_number"
        case lessonName = "lesson_name"
        case lessonTime = "lesson_time"
        case lessonDescription = "lesson_description"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        group = try container.decode(String.self, forKey: .group)
        comment = try container.decode(String.self, forKey: .comment)
        lessonNumber = try container.decode(String.self, forKey: .lessonNumber)
        lessonName = try container.decode(String.self, forKey: .lessonName)
        lessonTime = try container.decode(String.self, forKey: .lessonTime)
        lessonDescription = try container.decode(String.self, forKey: .lessonDescription)
        
        if let rawDate = try container.decodeIfPresent(String.self, forKey: .date) {
            date = DateFormatter.defaultFormatter.date(from: rawDate)
        } else {
            date = nil
        }

    }
}



