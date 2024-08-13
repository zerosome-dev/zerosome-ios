//
//  SocialRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class SocialRepository: SocialRepositoryProtocol {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    @MainActor
    func kakaoSignIn() async -> Result<String, NetworkError> {
        let result = await trySignInWithKakoa()
        
        guard let result else {
            return .failure(.badRequest)
        }
        
        return .success(result)
    }

    func appleSignIn(token: String, code: String) async -> Result<LoginResponseDTO, NetworkError> {
        let parameters: [String:String] = [
            "identityToken": token,
            "authorizationCode": code,
            "socialType": "APPLE"
        ]
        
        let endPoint = APIEndPoint.url(for: .signIn)
        
        let response: Result<LoginResponseDTO, NetworkError> = await apiService.request(
            httpMethod: .post,
            endPoint: endPoint,
            queryParameters: parameters,
            header: token)
        
        switch response {
        case .success(let success):
            debugPrint("🟢🍎🟢 애플 로그인 성공!! 🟢🍎🟢")
            return .success(success)
        case .failure(let failure):
            debugPrint("🔴🍎🔴 애플 로그인 실패 \(failure.localizedDescription) 🔴🍎🔴")
            return .failure(NetworkError.response)
        }
    }
//    func appleSignIn() async -> (String, String) {
//        let loginManager = AppleLoginManager()
//        
//        do {
//            let result = try await loginManager.login()
//            return result
//        } catch(let error) {
//            print(error.localizedDescription)
//        }
//        
//        return ("", "")
//    }
}

extension SocialRepository {
    
    @MainActor
    func trySignInWithKakoa() async -> String? {
        do {
            if UserApi.isKakaoTalkLoginAvailable() {
                return try await withCheckedThrowingContinuation { continuation in
                    UserApi.shared.loginWithKakaoTalk { (oautoken, error) in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let oauthToken = oautoken {
                            print("🍀 카카오 토큰 \(oauthToken)")
                            continuation.resume(returning: oauthToken.accessToken)
                        }
                    }
                }
            } else {
                print("🟡 카카오 로그인 서비스 사용 불가 🟡")
                return nil
            }
        } catch {
            return nil
        }
    }
}
