//
//  ScheduleEndpoints.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

enum ScheduleEndpoints {
    case groups
    case schedule(groupid: String, startDate: String, endDate: String)
}

extension ScheduleEndpoints: Endpoint {
    
    var parameters: [String : String]? {
        switch self {
        case .groups:
            return [
                "req_type": "obj_list",
                "req_mode": "group",
                "show_ID": "yes",
                "req_format": "json",
                "coding_mode": "UTF8",
                "bs": "ok"
            ]
        case .schedule(let groupid, let startDate, let endDate):
            return !isDebug ? [
                "req_type": "rozklad",
                "req_mode": "group",
                "OBJ_ID": "\(groupid)",
                "ros_text": "united",
                "begin_date": "\(startDate)",
                "end_date": "\(endDate)",
                "req_format": "json",
                "coding_mode": "UTF8",
                "bs": "ok"
            ] : [
                "req_type": "rozklad",
                "req_mode": "group",
                "OBJ_ID": "\(8573)",
                "ros_text": "united",
                "begin_date": "05.05.2022",
                "end_date": "13.05.2022",
                "req_format": "json",
                "coding_mode": "UTF8",
                "bs": "ok"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .groups:
            return "cgi-bin/timetable_export.cgi"
        case .schedule(let groupid, let startDate, let endDate):
            return "cgi-bin/timetable_export.cgi"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .groups:
            return .get
        case .schedule(let groupid, let startDate, let endDate):
            return .get
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .groups:
            return nil
        case .schedule(let groupid, let startDate, let endDate):
            return nil
        }
    }
    
    var header: [String: String]? {
            // Access Token to use in Bearer header
//            let accessToken = "Access Token here!"
//            switch self {
//            case .groups, .schedule(let groupid, let startDate, let endDate):
//                return [
//                    "Authorization": "Bearer \(accessToken)",
//                    "Content-Type": "application/json;charset=utf-8"
//                ]
//            }
        return nil
        }
    
}
