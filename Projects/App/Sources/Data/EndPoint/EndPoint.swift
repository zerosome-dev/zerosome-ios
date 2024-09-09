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
        case signIn = "/api/v1/auth"
        case checkNickname = "/api/v1/auth/nickname"
        case join = "/api/v1/auth/join"
        case refreshToken = "/api/v1/auth/refresh"
        case logout = "/api/v1/auth/logout"
        case changeNickname = "/api/app/v1/member/nickname"
    }
    
    enum Home: String {
        case banner = "/api/app/v1/home/banner"
        case tobeReleased = "/api/app/v1/home/rollout"
        case homeCafe = "/api/app/v1/home/cafe"
    }
    
    enum Category: String {
        case list = "/api/app/v1/category/list"
        case filteredProduct = "/api/app/v1/product/category"
        case d2CategoryList = "/api/app/v1/filter/sub-category"
        case brandList = "/api/app/v1/filter/brand"
        case zeroTagList = "/api/app/v1/filter/zero-category"
    }
    
    enum Review: String {
        case modifierReview = "/api/app/v1/member"
        case review = "/api/app/v1/review/list"
    }
    
    enum Mypage: String {
        case userInfo = "/api/app/v1/member"
        case userReviewList = "/api/app/v1/review/member"
    }
    
    enum Detail: String {
        case detail = "/api/app/v1/product/detail"
    }
    
    static func url(for endPoint: Auth, with parameters: [String : Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
    
    static func url(for endPoint: Home, with parameters: [String: Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
    
    static func url(for endPoint: Category, with parameters: [String: Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
    
    static func url(for endPoint: Detail, with parameters: [String: Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
    
    static func url(for endPoint: Review, with parameters: [String: Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
    
    static func url(for endPoint: Mypage, with parameters: [String: Any]? = nil) -> String {
        let base = baseURL + endPoint.rawValue
        return build(url: base, parameters: parameters)
    }
}

extension APIEndPoint {
    private static func build(url: String, parameters: [String: Any]?) -> String {
        guard let parameters = parameters, !parameters.isEmpty else {
            return url
        }
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        return urlComponents?.url?.absoluteString ?? url
    }
}
