//
//  LoginResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct LoginResponseDTO: Decodable {
    var isMember: Bool?
    var token: TokenResponseDTO?
}

struct TokenResponseDTO: Decodable {
    var accessToken: String?
    var refreshToken: String?
}
