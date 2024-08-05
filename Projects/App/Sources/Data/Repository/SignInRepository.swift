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
        var parameters: [String : String] = [:]
        parameters["socialType"] = socialType
        let endPoint = APIEndPoint.url(for: .signIn)
        
        let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: endPoint,
            queryParameter: parameters,
            header: token
        )
        
        switch response {
        case .success(let data):
            if let userToken = data.token,
               let accessToekn = userToken.accessToken,
               let refreshToken = userToken.refreshToken {
                AccountStorage.shared.accessToken = accessToekn
                AccountStorage.shared.refreshToken = refreshToken
                print("🟢 로그인 성공 \(data) 🟢")
                return .success(data)
            } else {
                print("🔴 로그인 > token값이 없어서 실패 🔴")
                return .failure(.unknown)
            }
        case .failure(let failure):
            print("🔴 로그인 실패 \(failure.localizedDescription)🔴")
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

/*
 func kakaoSignIn(token: String) async -> Result<LoginResponseDTO, NetworkError> {
     var parameters: [String : String] = [:]
     parameters["socialType"] = "KAKAO"

     let endPoint = APIEndPoint.url(for: .signIn) //, with: parameters)
     print("⚙️⚙️ endPoint!!!!! : \(endPoint)")
     
     let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
         httpMethod: .post,
         endPoint: endPoint,
         queryParameter: parameters,
         needToken: true,
         header: token
     )
     
     switch response {
     case .success(let data):
         if let userToken = data.token,
            let accessToekn = userToken.accessToken,
            let refreshToken = userToken.refreshToken {
             AccountStorage.shared.accessToken = accessToekn
             AccountStorage.shared.refreshToken = refreshToken
             print("🟡🟡 SignInRepository > kakaoSignIn SUCCESS \(data) 🟡🟡")
             return .success(data)
         } else {
             return .failure(.response)
         }
     case .failure(let failure):
         print("🟡🟡 SignInRepository > kakaoSignIn FAILURE \(failure.localizedDescription) 🟡🟡")
         debugPrint(failure.localizedDescription)
         return .failure(failure)
     }
 }
 
 func appleSignIn(token: String) async -> Result<LoginResponseDTO, NetworkError> {
     let endPoint = APIEndPoint.url(for: .signIn)
     var parameters: [String : String] = [:]
     parameters["socialType"] = "APPLE"
     
     let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
         httpMethod: .post,
         endPoint: endPoint,
         queryParameter: parameters,
         needToken: true,
         header: token
     )
     
     switch response {
     case .success(let data):
         if let userToken = data.token, // TODO: - 나중에 Mapper로 고쳐보기
            let accessToekn = userToken.accessToken,
            let refreshToken = userToken.refreshToken {
             AccountStorage.shared.accessToken = accessToekn
             AccountStorage.shared.refreshToken = refreshToken
             return .success(data)
         } else {
             return .failure(.response)
         }
     case .failure(let failure):
         debugPrint(failure.localizedDescription)
         return .failure(failure)
     }
 }
 
 
 @MainActor
 func getKakaoAccessToken() async -> Result<String, Error> {
     if UserApi.isKakaoTalkLoginAvailable() {
         return await withCheckedContinuation { continuation in
             UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                 if let error = error {
                     debugPrint("🟡🟡 SignInRepository > KAKAO ERROR \(error) 🟡🟡")
                     continuation.resume(returning: .failure(error))
                 } else {
                     if let token = oauthToken?.accessToken {
                         debugPrint("🟡🟡🟡 SignInRepository > KAKAO ACCESSTOKEN SUCCESS 🟡🟡🟡")
                         AccountStorage.shared.kakaoAccessToken = token
                         continuation.resume(returning: .success(token))
                     } else {
                         debugPrint("🔴🔴 SignInRepository > KAKAO ACCESSTOKEN FAILURE 🔴🔴")
                         let tokenError = NSError(domain: "LoginErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])
                         continuation.resume(returning: .failure(tokenError))
                     }
                 }
             }
         }
     } else {
         debugPrint("🔴🔴🔴 SignInRepository > KAKAO ACCESSTOKEN FAILURE 🔴🔴🔴")
         let error = NSError(domain: "LoginErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "KakaoTalk is not available"])
         return .failure(error)
     }
 }
 
 */
