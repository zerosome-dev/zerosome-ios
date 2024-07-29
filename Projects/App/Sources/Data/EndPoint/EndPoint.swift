//
//  EndPoint.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

struct APIEndPoint {
    static let baseURL = "http://15.164.6.36:8080"
    
    enum Auth: String {
        case login = "/api/v1/auth"
        case checkNickname = "/api/v1/auth/nickname"
        case join = "/api/v1/auth/join"
        case refreshToken = "/api/v1/auth/refresh"
        case logout = "/api/v1/auth/logout"
        case revoke = "/api/v1/auth/reovke" // ??미정
    }
    
    enum Home: String {
        case banner = "/api/app/v1/home/banner"
        case tobeReleased = "/api/app/v1/home/rollout"
        case homeCafe = "/api/app/v1/home/cafe"
    }
    
    enum Category: String {
        case list = "/api/app/v1/category/list"
    }
    
    static func url(for endPoint: Auth) -> String {
        return baseURL + endPoint.rawValue
    }
    
    static func url(for endPoint: Home) -> String {
        return baseURL + endPoint.rawValue
    }
    
    static func url(for endPoint: Category) -> String {
        return baseURL + endPoint.rawValue
    }
}
