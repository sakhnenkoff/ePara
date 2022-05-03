//
//  ScheduleService.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

protocol ScheduleServicing {
    var networkClient: NetworkClient { get }
    
//    func fetchScheduleForGroup(id: Int) async -> Result<Export, RequestError>
    func fetchDepartments() async -> Result<Export, RequestError>
}

struct ScheduleService: ScheduleServicing {
    
    var networkClient: NetworkClient
    
    init(with client: NetworkClient) {
        self.networkClient = client
    }
    
    // MARK: Actions
    
//    func fetchScheduleForGroup(id: Int) async -> Result<Export, RequestError> {
//
//    }
    
    func fetchDepartments() async -> Result<Export, RequestError> {
        return await networkClient.sendRequest(endpoint: ScheduleEndpoints.groups, responseModel: Export.self)
    }

}
