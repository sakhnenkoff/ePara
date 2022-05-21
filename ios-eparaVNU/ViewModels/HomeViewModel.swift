//
//  HomeViewModel.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 09.04.2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var itemsToDisplay: [ScheduleItem]?
    
    var currenltyDisplayedLessons: [Lesson] {
        guard let itemsToDisplay = itemsToDisplay else { return [] }
        return itemsToDisplay.map() { Lesson(for: $0) }
    }

    private let scheduleService: ScheduleServicing
        
    var currentSelectedDate = Date() {
        didSet {
            if hasFetchedSchedules && !(fetchedSchedule?.isEmpty ?? true) {
                filterSchedule()
            }
        }
    }
    
    var hasFetchedSchedules = false
    
    var fetchedSchedule: [ScheduleItem]? {
        didSet {
            print(fetchedSchedule)
            filterSchedule()
        }
    }
    
    var fetchedDepartaments: [Department]? {
        didSet {
            print(fetchedDepartaments)
        }
    }
    
    init() {
        self.scheduleService = ScheduleService(with: Client())
    }
    
    // MARK: Output:
    
    func didChangeSelectedDate(date: Date, monthOffset: Int?) {
        self.currentSelectedDate = date
    }
    
    // MARK: Helpers
    
    private func filterSchedule() {
        guard let fetchedSchedule = fetchedSchedule else { print("No Schedule to be Filtered"); return }
        // TO-DO -- Throw an Error
        itemsToDisplay = fetchedSchedule.filter() {
            guard let date = $0.date else { return false }

            let convertedDateString = DateFormatter.defaultExternalFormatter.string(from: date)
            let selectedDateString = DateFormatter.defaultFormatter.string(from: currentSelectedDate)
            return convertedDateString.isTheSameString(with: selectedDateString) && !$0.lessonDescription.isEmpty
        }
    }
    
    // MARK: Networking
    
    func fetchDepartaments() async {
        let result = try await scheduleService.fetchDepartments()
        switch result {
        case .failure(let e):
            print("Error while fetching the data: \(e.customMessage)")
        case .success(let exportedData):
            DispatchQueue.main.async {
                self.fetchedDepartaments = exportedData.export.departments
            }
        }
    }
    
    func fetchSchedule(with groupId: String, stardDate: String, endDate: String) async {
        let result = try await scheduleService.fetchScheduleForGroup(id: groupId, startDate: stardDate, endDate: endDate)
        switch result {
        case .failure(let e):
            print("Error while fetching the data: \(e.customMessage)")
        case .success(let exportedData):
            DispatchQueue.main.async {
                self.fetchedSchedule = exportedData.export.scheduleItems
                self.hasFetchedSchedules = true
            }
        }
    }
    
}
