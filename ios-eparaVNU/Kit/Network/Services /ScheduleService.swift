//
//  ScheduleService.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

protocol ScheduleServicing {
    var networkClient: NetworkClient { get }
    
    func fetchScheduleForGroup(id: String, startDate: String, endDate: String) async -> Result<ApiResponse, RequestError>
    func fetchDepartments() async -> Result<ApiResponse, RequestError>
}

struct ScheduleService: ScheduleServicing {
    
    var networkClient: NetworkClient
    
    init(with client: NetworkClient) {
        self.networkClient = client
    }
    
    // MARK: Actions
    
    func fetchDepartments() async -> Result<ApiResponse, RequestError> {
        if #available(iOS 15.0, *) {
            return await networkClient.sendRequest(endpoint: ScheduleEndpoints.groups, responseModel: ApiResponse.self)
        } else {
            // Fallback on earlier versions
            return .failure(.unknown)
        }
    }
    
    func fetchScheduleForGroup(id: String, startDate: String, endDate: String) async -> Result<ApiResponse, RequestError> {
        if #available(iOS 15.0, *) {
            return await networkClient.sendRequest(endpoint: ScheduleEndpoints.schedule(groupid: id, startDate: startDate , endDate: endDate), responseModel: ApiResponse.self)
        } else {
            // Fallback on earlier versions
            return .failure(.unknown)
        }
    }

}
