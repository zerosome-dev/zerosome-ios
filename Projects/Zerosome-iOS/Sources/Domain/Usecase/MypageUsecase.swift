//
//  MypageUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

struct MypageUsecase {
    let mypageRepoProtocol: MypageRepositoryProtocol
    
    func getUserBasicInfo() -> Future<MemberBasicInfoResult, NetworkError> {
        return mypageRepoProtocol.getUserBasicInfo()
    }
    
    func logout() -> Future<Bool, NetworkError> {
        return mypageRepoProtocol.logout()
    }
    
    func revoke() -> Future<Bool, NetworkError> {
        return mypageRepoProtocol.revoke()
    }
}
