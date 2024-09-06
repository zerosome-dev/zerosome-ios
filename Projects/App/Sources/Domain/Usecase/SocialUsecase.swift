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
    
    @MainActor
    func kakaoLogin() async -> Result<String, NetworkError> {
        let repository = await socialRepoProtocol.kakaoSignIn()
        
        switch repository {
        case .success(let success):
            AccountStorage.shared.kakaoToken = success
            return .success(success)
        case .failure(let failure):
            debugPrint("카카오 토큰 가져오기 실패 \(failure.localizedDescription)")
            return .failure(NetworkError.badRequest)
        }
    }
    
    @MainActor
    func appleLogin() async -> Result<String, NetworkError> {
        
        let repository = await socialRepoProtocol.appleSignIn()
        
        switch repository {
        case .success(let success):
            AccountStorage.shared.appleToken = success
            return .success(success)
        case .failure(let failure):
            debugPrint("애플 토큰 가져오기 실패 \(failure.localizedDescription)")
            return .failure(NetworkError.badRequest)
        }
    }
}
