//
//  SocialRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

protocol SocialRepositoryProtocol {
    func kakaoSignIn() async -> Result<String, NetworkError>
    func appleSignIn() async -> Result<LoginResponseDTO, NetworkError>
//    func getKakaoAccessToken() async -> Result<String, Error>
}
