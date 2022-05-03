//
//  HomeViewViewModel.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 09.04.2022.
//

import Foundation

final class HomeViewViewModel: ObservableObject {

    private let scheduleService: ScheduleServicing
    
    init() {
        self.scheduleService = ScheduleService(with: Client())
    }
    
    // MARK: Input
    
    func fetch() async {
        let result = try await scheduleService.fetchDepartments()
        switch result {
        case .failure(let e):
            print("Error while fetching the data: \(e.customMessage)")
        case .success(let exportedData):
            print(exportedData.departments)
        }
    }
    
}
