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
        let parameters: [String : String] = ["socialType" : socialType]
        let endPoint = APIEndPoint.url(for: .signIn)
        
        let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: endPoint,
            queryParameters: parameters,
            header: token
        )
        
        switch response {
        case .success(let success):
            AccountStorage.shared.accessToken = success.token?.accessToken
            AccountStorage.shared.refreshToken = success.token?.refreshToken
            debugPrint("🟢 로그인 함수 성공 + 스토리지 저장 완료 \(success) 🟢")
            return .success(success)
        case .failure(let failure):
            debugPrint("🔴 Failure postSignIn > 로그인 실패 \(failure.localizedDescription)🔴")
            return .failure(failure)
        }
    }
    
    func postSignUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<TokenResponseDTO, NetworkError> {
        let parameters: [String:String] = ["socialType" : socialType]
        let endPoint = APIEndPoint.url(for: .join)
        
        print("token???? \(token)")
        let response: Result<TokenResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: endPoint,
            queryParameters: parameters,
            body: (
                JoinRequest(
                    nickname: nickname,
                    agreement_marketing: marketing
                )
            ),
            header: token
        )
        
        switch response {
        case .success(let success):
            debugPrint("🟢 회원가입 성공 \(success) 🟢")
            AccountStorage.shared.accessToken = success.accessToken
            AccountStorage.shared.refreshToken = success.refreshToken
            debugPrint("🟢 회원가입 성공 > AccountStorage 저장 완료 🟢")
            return .success(success)
                       
        case .failure(let failure):
            debugPrint("🔴 회원가입 실패 \(failure.localizedDescription) 🔴")
            return .failure(failure)
        }
    }
    
    func checkNickname(nickname: String) async -> Result<Bool, NetworkError> {
        let parameters: [String:String] = ["nickname" : nickname]
        
        let response: Result<Bool, NetworkError> = await apiService.request(
            httpMethod: .get,
            endPoint: APIEndPoint.url(for: .checkNickname),
            queryParameters: parameters
        )
        
        switch response {
        case .success(let success):
            print("🍀🍀 닉네임 유효성 체크 확인 > 성공 🍀🍀")
            return .success(success)
        case .failure(let failure):
            print("😡😡 닉네임 유효성 체크 실패 > \(failure.localizedDescription)")
            return .failure(.badRequest)
        }
    }
}
