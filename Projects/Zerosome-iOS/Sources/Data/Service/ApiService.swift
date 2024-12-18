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
        queryParameters: Encodable? = nil,
        pathParameters: String? = nil,
        body: Encodable? = nil,
        header: String? = nil
    ) async -> Result<T, NetworkError> {
        
        var modifiedEndPoint = endPoint
        
        if let pathParameter = pathParameters {
            modifiedEndPoint = modifiedEndPoint + "/\(pathParameter)"
        }
        
        guard var url = URL(string: modifiedEndPoint) else {
            return .failure(NetworkError.urlError)
        }
        
        if let parameters = queryParameters {
            guard let queryDictionary = try? parameters.toDictionary() else {
                return .failure(NetworkError.queryError)
            }
            
            var queryItems: [URLQueryItem] = []
            
            queryDictionary.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            url.append(queryItems: queryItems)
        }
        
//        debugPrint("🚨🚨 <<<EndPoint>>> \(modifiedEndPoint) 🚨🚨")
//        debugPrint("🚨🚨 <<<URL>>> \(url) 🚨🚨")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            urlRequest.allHTTPHeaderFields = createHeaders(token: header)
//            debugPrint("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
        }
        
        if let body = body {
            do {
                let httpBody = try JSONEncoder().encode(body)
                urlRequest.httpBody = httpBody
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
//                debugPrint("🚨🚨 <<<HTTP BODY>>> \(body) 🚨🚨")
//                debugPrint("🚨🚨 <<<HTTP HTTPBODY>>> \(httpBody) 🚨🚨")
//                debugPrint("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
            } catch {
                return .failure(NetworkError.encode)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            debugPrint("🚨🚨 <<<Response>>> \(response) 🚨🚨")
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(NetworkError.response)
            }
            
//            print("😈😈 STATUS CODE \(statusCode) 😈😈")
            let range = 200..<300
            guard range.contains(statusCode) else {
                return .failure(NetworkError.statusError)
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                debugPrint("🚨🚨 <<<JSON Data>>> 🚨🚨 \(jsonObject)")
            } catch {
//                debugPrint("🚨🚨 <<<JSON Serialization Error>>> 🚨🚨 \(error.localizedDescription)")
//                return .failure(NetworkError.decode)
            }
                        
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                guard let data = result.data else {
                    return .failure(NetworkError.decode)
                }
//                debugPrint("🚨🚨 <<<Data>>> \(data)🚨🚨")
                return .success(data)
            } catch {
//                debugPrint("🚨🚨 <<<Network Decode Error>>> 🚨🚨 \(error.localizedDescription)")
                return .failure(NetworkError.decode)
            }
                    
        } catch {
            debugPrint("🚨🚨 <<< Network Error >>> 🚨🚨 \(error.localizedDescription)")
            return .failure(NetworkError.apiError)
        }
    }
}


extension ApiService {
    func noneDecodeRequest (
        httpMethod: ApiMethod,
        endPoint: String,
        queryParameters: Encodable? = nil,
        pathParameters: String? = nil,
        body: Encodable? = nil,
        header: String? = nil
    ) async -> Result<Bool, NetworkError> {
        
        var modifiedEndPoint = endPoint
        
        if let pathParameter = pathParameters {
            modifiedEndPoint = modifiedEndPoint + "/\(pathParameter)"
        }
        
        guard var url = URL(string: modifiedEndPoint) else {
            return .failure(NetworkError.urlError)
        }
        
        if let parameters = queryParameters {
            guard let queryDictionary = try? parameters.toDictionary() else {
                return .failure(NetworkError.queryError)
            }
            
            var queryItems: [URLQueryItem] = []
            
            queryDictionary.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            url.append(queryItems: queryItems)
        }
        
//        debugPrint("🚨🚨 <<<EndPoint>>> \(modifiedEndPoint) 🚨🚨")
//        debugPrint("🚨🚨 <<<URL>>> \(url) 🚨🚨")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            urlRequest.allHTTPHeaderFields = createHeaders(token: header)
//            debugPrint("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
        }
        
        if let body = body {
            do {
                let httpBody = try JSONEncoder().encode(body)
                urlRequest.httpBody = httpBody
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
//                debugPrint("🚨🚨 <<<HTTP BODY>>> \(body) 🚨🚨")
//                debugPrint("🚨🚨 <<<HTTP HTTPBODY>>> \(httpBody) 🚨🚨")
//                debugPrint("🚨🚨 <<<HTTP HEARDERFIELDS>>> \(String(describing: urlRequest.allHTTPHeaderFields)) 🚨🚨")
            } catch {
                return .failure(NetworkError.encode)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            debugPrint("🚨🚨 <<<Response>>> \(response) 🚨🚨")
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(NetworkError.response)
            }
            
//            print("😈😈 STATUS CODE \(statusCode) 😈😈")
            let range = 200..<300
            guard range.contains(statusCode) else {
                return .failure(NetworkError.statusError)
            }

//            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                debugPrint("🚨🚨 <<<JSON Data>>> 🚨🚨 \(jsonObject)")
//                
//                if let jsonDict = jsonObject as? [String: Any],
//                   let dataDict = jsonDict["data"] as? [String: Any],
//                   let contentArray = dataDict["content"] as? [[String: Any]] {
//                    for item in contentArray {
//                        print("Item: \(item)")
//                    }
//                } else {
//                    print("Content is empty or not a dictionary array.")
//                }
//            } catch {
//                debugPrint("🚨🚨 <<<JSON Serialization Error>>> 🚨🚨 \(error.localizedDescription)")
//            }
            
            do {
                let result = try JSONDecoder().decode(Response<NoneDecodeResponse>.self, from: data)

                guard result.data != nil else {
                    print("🩵🩵🩵Decoding success > Data 결과 NULL > 성공🩵🩵🩵")
                    return .success(true)
                }
                
                return .failure(NetworkError.decode)
            } catch {
                debugPrint("🚨🚨 <<<Network Decode Error>>> 🚨🚨 \(error.localizedDescription)")
                return .failure(NetworkError.decode)
            }
        } catch {
            debugPrint("🚨🚨 <<< Network Error >>> 🚨🚨 \(error.localizedDescription)")
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
