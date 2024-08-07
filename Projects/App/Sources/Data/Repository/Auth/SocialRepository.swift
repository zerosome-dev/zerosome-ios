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

    @MainActor
    func kakaoSignIn() async -> Result<String, NetworkError> {
        let result = await trySignInWithKakoa()
        
        guard let result else {
            return .failure(.badRequest)
        }
        
        return .success(result)
    }
    
    func appleSignIn() async -> (String, String) {
        let loginManager = AppleLoginManager()
        
        do {
            let result = try await loginManager.login()
            return result
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        return ("", "")
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
