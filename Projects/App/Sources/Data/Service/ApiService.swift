//
//  ApiService.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

enum ApiMethod {
    case get
    case put
    case post
    case patch
    case delete
}

class ApiService {
    func request(
        apiMethod: ApiMethod,
        endPoint: String,
        QueryParameter: [String : String]? = nil
    ) async -> Result<Data, NetworkError> {
        return .failure(.notConnected)
        
        // TODO: - Network 작업

    }
}

