//
//  ApiService.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

final class ApiService {
    
    init() { }
    
    func request<T: Decodable> (
        httpMethod: ApiMethod,
        _ endPoint: String,
        queryParameter: [String : String]? = nil,
        needToken: Bool
    ) async -> Result<T, NetworkError> {
        
        guard var url = URL(string: endPoint) else {
            return .failure(NetworkError.urlError)
        }
              
        if let parameters = queryParameter {
            guard let queryDictionary = try? queryParameter?.toDictionary() else {
                return .failure(NetworkError.queryError)
            }
            
            var queryItems: [URLQueryItem] = []
            
            queryDictionary.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            url.append(queryItems: queryItems)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = createHeaders(needToken: needToken)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(NetworkError.response)
            }
            
            let range = 200..<300
            guard range.contains(statusCode) else {
                return .failure(NetworkError.statusError)
            }
            
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                
                guard let data = result.data else {
                    return .failure(NetworkError.decode)
                }
                
                return .success(data)
                
            } catch {
                print("🚨 Network Decode Error \(error.localizedDescription)")
                return .failure(NetworkError.decode)
            }
        } catch {
            print("🚨 Network Error \(error.localizedDescription)")
            return .failure(NetworkError.apiError)
        }
    }
    
    func upload(
        _ url: String,
        httpMethod: ApiMethod,
        data: Data,
        needToken: Bool = false
    ) async throws -> Bool {
        
        guard let url = URL(string: url) else {
            throw NetworkError.urlError
        }
        
        debugPrint("🥦 Request Start")
        debugPrint("🥦 url: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = createHeaders(needToken: needToken)
        
        let (responsData, response) = try await URLSession.shared.upload(for: request, from: data)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.statusError
        }
        
        return true
    }
}

extension ApiService {
    
    // ?? 미정
    var token: String? {
        if let token = KeychainManager.shared.load(key: "accessToken") {
            return token.description
        } else {
            return ""
        }
    }
    
    private func createHeaders(needToken: Bool) -> [String : String] {
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if needToken, let token = AccountStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
}
