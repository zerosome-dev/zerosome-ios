//
//  AccountUseCase.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct AccountUseCase {
    let accountRepoProtocol: AccountRepositoryProtocol
    
    func signIn(token: String, socialType: String) async -> Result<LoginResponseDTO, NetworkError> {
        await accountRepoProtocol.postSignIn(token: token, socialType: socialType)
    }
    
    
    func signUp(token: String, socialType: String, nickname: String, marketing: Bool) async -> Result<LoginResponseDTO, NetworkError> {
        await accountRepoProtocol.postSignUp(token: token, socialType: socialType, nickname: nickname, marketing: marketing)
    }
    
//    func kakaoLogin() async -> Result<LoginResponseDTO, NetworkError> {
//        
//        let kakao = await signInRepoProtocol.getKakaoAccessToken()
//        
//        switch kakao {
//        case .success(let token):
//            print("🟡🟡 카카오 토큰 값 받아오기 성공 🟡🟡")
//            let signInResult = await signInRepoProtocol.kakaoSignIn(token: token)
//            
//            switch signInResult {
//            case .success(let success):
//                print("🟡🟡 카카오로 이미 회원가입 된 유저의 로그인 성공 🟡🟡")
//                return .success(success)
//            case .failure(let failure):
//                print("🚨🚨 SIGNINUSECASE KAKAO, 카카오로 회원가입 진행(닉네임 페이지로 이동) \(failure.localizedDescription) 🚨🚨")
//                return .failure(NetworkError.response)
//            }
//        case .failure(let failure):
//            print("here failure APPLE ㅜㅜㅜ \(failure.localizedDescription)")
//            return .failure(.response)
//        }
//    }
//    
//    func appleLogin() async -> Result<LoginResponseDTO, NetworkError> {
//        let appleLoginManager = AppleLoginManager()
//        do {
//            let (token, code) = try await appleLoginManager.login()
//            return await signInRepoProtocol.appleSignIn(token: token)
//        } catch {
//            return .failure(NetworkError.apiError)
//        }
//    }
}
