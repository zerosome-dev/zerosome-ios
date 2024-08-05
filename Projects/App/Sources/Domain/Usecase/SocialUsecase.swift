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
            print("🍀🍀🍀 카카오 토큰 가져와짐 \(success)")
            return .success(success)
        case .failure(let failure):
            debugPrint("카카오 토큰 가져오기 실패 \(failure.localizedDescription)")
            return .failure(NetworkError.badRequest)
        }
    }
    
    func appleLogin() {
        
    }
}
