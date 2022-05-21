//
//  Client.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 03.05.2022.
//

import Foundation

protocol NetworkClient: AnyObject {
    @available (iOS 15.0, *)
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completion: (Result<T, RequestError>) -> Void)
}

extension NetworkClient {
    @available (iOS 15.0, *)
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var params: String {
            guard let parameters = endpoint.parameters else { return "" }
            var paramsString = "?"
            
            for (key, value) in parameters {
                if paramsString == "?" {
                    paramsString.append("\(key)=\(value)")
                } else {
                    paramsString.append("&\(key)=\(value)")
                }
            }
            
            return paramsString
        }
        
        let urlString = endpoint.baseURL + endpoint.path + params
        print(urlString)
        
        guard let url = URL(string: urlString) else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = endpoint.method.name
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

final class Client: NetworkClient {
    
    @available (iOS 15.0, *)
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var params: String {
            guard let parameters = endpoint.parameters else { return "" }
            var paramsString = "?"
            
            for (key, value) in parameters {
                if paramsString == "?" {
                    paramsString.append("\(key)=\(value)")
                } else {
                    paramsString.append("&\(key)=\(value)")
                }
            }
            
            return paramsString
        }
        
        let urlString = endpoint.baseURL + endpoint.path + params
        print(urlString)
        
        guard let url = URL(string: urlString) else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = endpoint.method.name
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
//                    print("JSON String: \(String(data: data, encoding: .utf8))")
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    // iOS 14 method
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completion: (Result<T, RequestError>) -> Void) {
        print("currently a dummy method")
    }
}

