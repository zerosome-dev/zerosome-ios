//
//  AccountRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

protocol AccountRepositoryProtocol {
    func postSignIn(token: String, socialType: String) async -> Result<LoginResponseDTO, NetworkError>
    func postSignUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<TokenResponseDTO, NetworkError>
    func checkNickname(nickname: String) async -> Result<Bool, NetworkError>
    func putNickname(nickname: String) -> Future<Bool, NetworkError>
    func checkUserToken() -> Future<MemberBasicInfoResult, NetworkError>
    func refreshToken() -> Future<TokenResponseResult, NetworkError>
}

