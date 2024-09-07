//
//  AuthMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

final class AuthMapper {
    static func toRefreshToken(response: TokenResponseDTO) -> TokenResponseResult {
        return TokenResponseResult(
            accessToken: response.accessToken ?? "",
            refreshToken: response.refreshToken ?? ""
        )
    }
}
