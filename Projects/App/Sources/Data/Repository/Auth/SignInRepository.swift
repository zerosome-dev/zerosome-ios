//
//  DataRepository.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class AccountRepository: AccountRepositoryProtocol {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func postSignIn(token: String, socialType: String) async -> Result<LoginResponseDTO, NetworkError> {
        var parameters: [String : String] = ["socialType" : socialType]
        let endPoint = APIEndPoint.url(for: .signIn)
        
        let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: endPoint,
            queryParameters: parameters,
            header: token
        )
        
        switch response {
        case .success(let data):
            AccountStorage.shared.accessToken = data.token?.accessToken
            AccountStorage.shared.refreshToken = data.token?.refreshToken
            
//            guard let isMember = data.isMember else {
//                print("🟢🔴 로그인 실패, 회원가입 진행 🟢🔴")
//                return .success(data)
//            }
            print("🟢 로그인 성공 \(data) 🟢")
            return .success(data)
            
        case .failure(let failure):
            print("🔴 Failure postSignIn > 로그인 실패 \(failure.localizedDescription)🔴")
            return .failure(failure)
        }
    }
    
    func postSignUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<LoginResponseDTO, NetworkError> {
        AccountStorage.shared.accessToken = token
        
        let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: APIEndPoint.url(for: .join),
            body: (
                JoinRequest(
                    nickname: nickname,
                    marketing: marketing
                )
            ),
            header: token
        )
        
        switch response {
        case .success(let success):
            print("🟢 회원가입 성공 \(success) 🟢")
            return .success(success)
        case .failure(let failure):
            print("🔴 회원가입 실패 \(failure.localizedDescription) 🔴")
            return .failure(failure)
        }
    }
}
