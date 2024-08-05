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
        endPoint: String,
        queryParameter: Encodable? = nil,
        body: Encodable? = nil,
//        needToken: Bool = false,
        header: String? = nil
    ) async -> Result<T, NetworkError> {
        
        guard var url = URL(string: endPoint) else {
            return .failure(NetworkError.urlError)
        }
        
        if let parameters = queryParameter {
            guard let queryDictionary = try? parameters.toDictionary() else {
                return .failure(NetworkError.queryError)
            }
            
            var queryItems: [URLQueryItem] = []
            
            queryDictionary.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            url.append(queryItems: queryItems)
        }
        print("⚙️⚙️ URL \(url) ⚙️⚙️")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            urlRequest.allHTTPHeaderFields = createHeaders(token: header)
            print("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
        }
        
        if let body = body {
            guard let httpBody = try? JSONEncoder().encode(body) else {
                return .failure(NetworkError.encode)
            }
            
            urlRequest.httpBody = httpBody
            print("🚨🚨 <<<HTTP BODY>>> \(body) 🚨🚨")
            print("🚨🚨 <<<HTTP HTTPBODY>>> \(httpBody) 🚨🚨")
            print("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(NetworkError.response)
            }
            
            print("😈😈 STATUS CODE \(statusCode) 😈😈")
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
}

extension ApiService {
    
    private func createHeaders(token: String) -> [String : String] {
        
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json; charset=utf-8",
            "Accept-Charset": "UTF-8"
        ]
    }
}

/*
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
 */
