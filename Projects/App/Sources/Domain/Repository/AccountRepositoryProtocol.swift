//
//  AccountRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

protocol AccountRepositoryProtocol {
//    func kakaoSignIn(token: String) async -> Result<LoginResponseDTO, NetworkError>
//    func appleSignIn(token: String) async -> Result<LoginResponseDTO, NetworkError>
//    func getKakaoAccessToken() async -> Result<String, Error>
    
    func postSignIn(token: String, socialType: String) async -> Result<LoginResponseDTO, NetworkError>
    func postSignUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<LoginResponseDTO, NetworkError>
}

