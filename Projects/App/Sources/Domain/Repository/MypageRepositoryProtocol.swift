//
//  MypageRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

protocol MypageRepositoryProtocol {
    func getUserBasicInfo() -> Future<MemberBasicInfoResult, NetworkError>
    func logout() -> Future<Bool, NetworkError>
    func revoke() -> Future<Bool, NetworkError>
}
