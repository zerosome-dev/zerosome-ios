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
    
    func appleSignIn() async -> Result<String, NetworkError> {
        let appleLoginManager = AppleLoginManager()
        
        do {
            let (token, _) = try await appleLoginManager.login()
            debugPrint("🟢🍏🟢 애플 로그인 시도 성공 🟢🍏🟢")
            return .success(token)
            
        } catch(let error) {
            debugPrint("🔴🍎🔴 애플 로그인 시도 실패 \(error.localizedDescription) 🔴🍎🔴")
            return .failure(NetworkError.badRequest)
        }
    }
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
                            continuation.resume(returning: oauthToken.accessToken)
                        }
                    }
                }
            } else {
                debugPrint("🟡 카카오 로그인 서비스 사용 불가 > 카카오 앱 없음 🟡")
                return try await withCheckedThrowingContinuation { continuation in
                    UserApi.shared.loginWithKakaoAccount { (oauthtoken, error) in
                        if let error = error {
                            debugPrint("🍀 error \(error.localizedDescription)")
                            continuation.resume(throwing: error)
                        } else if let oauthToken = oauthtoken {
                            continuation.resume(returning: oauthToken.accessToken)
                        }
                    }
                }
            }
        } catch {
            debugPrint("🟡 카카오 로그인 서비스 완전 사용 불가 🟡")
            return nil
        }
    }
}
