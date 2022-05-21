//
//  DateValue.swift
//  ElegantTasks
//
//  Created by Matthew Sakhnenko on 18.05.2022.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
