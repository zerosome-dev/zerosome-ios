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
//    func appleSignIn() async -> (String, String)
    func appleSignIn(token: String, code: String) async -> Result<LoginResponseDTO, NetworkError>
}
