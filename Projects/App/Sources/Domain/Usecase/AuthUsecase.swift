//
//  AuthUseCase.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct AuthUseCase {
    let authRepoInterface: AuthRepositoryRepoInterface
    
    func kakaoLogin(_ token: String) async -> Result<String, NetworkError> {
        return await authRepoInterface.kakaoLogin(token)
    }
}