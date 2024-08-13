//
//  SocialUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct SocialUsecase {
    
    let socialRepoProtocol: SocialRepositoryProtocol
    
    func kakaoLogin() async -> Result<String, NetworkError> {
        let repository = await socialRepoProtocol.kakaoSignIn()
        
        switch repository {
        case .success(let success):
            AccountStorage.shared.accessToken = success
            debugPrint("🟡🟡 카카오 토큰 가져와짐 \(success)")
            debugPrint("🟡🟡🍀 AccountStorage.shared.accossToken \(AccountStorage.shared.accessToken ?? "🟡🟡🔴🍀")")
            return .success(success)
        case .failure(let failure):
            debugPrint("카카오 토큰 가져오기 실패 \(failure.localizedDescription)")
            return .failure(NetworkError.badRequest)
        }
    }
    
    func appleLogin() async -> Result<LoginResponseDTO, NetworkError> {
        let appleLoginManager = AppleLoginManager()
        
        do {
            let (token, code) = try await appleLoginManager.login()
            let response = await socialRepoProtocol.appleSignIn(token: token, code: code)
            
            switch response {
            case .success(let success):
                print("🟢🍏🟢 서버 <> 애플 로그인 성공, token > accountStorage 저장 🟢🍏🟢")
                print("🌟token \(token)")
                AccountStorage.shared.accessToken = token
                print("🌟AccountStorage.shared.accessToken \(AccountStorage.shared.accessToken)")
                return .success(success)
            case .failure(let failure):
                print("🔴🍎🔴 서버 <> 애플 로그인 실패 🔴🍎🔴")
                return .failure(NetworkError.unknown)
            }
            
        } catch(let error) {
            print("🔴🍎🔴 애플 로그인 시도 실패 \(error.localizedDescription) 🔴🍎🔴")
            return .failure(NetworkError.unknown)
        }
    }
}
