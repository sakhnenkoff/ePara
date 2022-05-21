//
//  User.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 17.05.2022.
//

import Foundation
import SwiftUI

// MARK: DUMMY DATA 

struct Lesson: Identifiable {
    let group: String
    let lessonDescription: String
    let lessonNumber: String
    let lessonTime: String
    let lessonDate: Date?
    
    var id: String {
        stringDate + group + lessonNumber + lessonDescription
    }
    
    var stringDate: String {
        let dateformatter: DateFormatter = .defaultFormatter
        return dateformatter.string(from: lessonDate ?? Date())
    }
}

extension Lesson {
    init(for item: ScheduleItem) {
        self.group = item.group
        self.lessonDescription = item.lessonDescription
        self.lessonNumber = item.lessonNumber
        self.lessonTime = item.lessonTime
        self.lessonDate = item.date
    }
}

extension Lesson {
    static let lessons: [Lesson] = [
        Lesson(group: "КНІТ-23", lessonDescription: "Теорія ймовірностей та математична статистика (Пр) доц. Ковальчук І.Р. ауд. С-519", lessonNumber: "3", lessonTime: "11:50-13:10", lessonDate: DateFormatter.defaultFormatter.date(from: "20.05.2022"))
    ]
}
