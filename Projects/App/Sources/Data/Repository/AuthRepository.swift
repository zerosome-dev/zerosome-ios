//
//  DataRepository.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class AuthRepository: AuthRepositoryProtocol {
    
    let apiService = ApiService()
    
    func kakaoLogin(_ token: String) async -> Result<String, NetworkError> {
        // TODO: - Implement Kakao Login
        
        return .success("success")
    }
}
