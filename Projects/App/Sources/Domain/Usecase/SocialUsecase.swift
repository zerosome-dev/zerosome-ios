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
            return .success(success)
        case .failure(let failure):
            return .failure(NetworkError.badRequest)
        }
    }
    
    func appleLogin() {
        
    }
}
