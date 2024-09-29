//
//  AccountUseCase.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

struct AccountUseCase {
    let accountRepoProtocol: AccountRepositoryProtocol
    
    func signIn(token: String, socialType: String) async -> Result<LoginResponseDTO, NetworkError> {
        await accountRepoProtocol.postSignIn(token: token, socialType: socialType)
    }
    
    func signUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<TokenResponseDTO, NetworkError> {
        await accountRepoProtocol.postSignUp(token: token, socialType: socialType, nickname: nickname, marketing: marketing)
    }
    
    func checkNickname(nickname: String) async -> Result<Bool, NetworkError> {
        await accountRepoProtocol.checkNickname(nickname: nickname)
    }
    
    func putNickname(nickname: String) -> Future<Bool, NetworkError> {
        return accountRepoProtocol.putNickname(nickname: nickname)
    }
    
    func checkUserToken() -> Future<MemberBasicInfoResult, NetworkError> {
        return accountRepoProtocol.checkUserToken()
    }
    
    func checkRefreshToken() -> Future<TokenResponseResult, NetworkError> {
        return accountRepoProtocol.refreshToken()
    }
}
