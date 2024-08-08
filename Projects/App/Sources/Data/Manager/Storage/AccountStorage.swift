//
//  AccountStorage.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

final class AccountStorage {
    static var shared = AccountStorage()
    
    var isGuest: Bool {
        return accessToken?.isEmpty ?? true
    }
    var accessToken: String? {
        get {
            guard let value = KeychainManager.load(key: "accessToken"),
                  !value.isEmpty,
                  let token = String(data: value, encoding: String.Encoding.utf8) else {
                return nil
            }
            debugPrint("🔮 get accessToken : \(token)")
            return token
        }
        set {
            if let value = newValue, let data = value.data(using: .utf8) {
                KeychainManager.save(key: "accessToken", data: data)
                debugPrint("🔮 save accessToken : \(value)")
            } else {
                KeychainManager.delete(key: "accessToken")
                debugPrint("🔮 delete accessToken")
            }
        }
    }
    
    var refreshToken: String? {
        get {
            guard let value = KeychainManager.load(key: "refreshToken"),
                  !value.isEmpty,
                  let token = String(data: value, encoding: String.Encoding.utf8) else {
                return nil
            }
            debugPrint("🔮 get refreshToken : \(token)")
            return token
        }
        set {
            if let value = newValue, let data = value.data(using: .utf8) {
                KeychainManager.save(key: "refreshToken", data: data)
                debugPrint("🔮 save refreshToken : \(value)")
            } else {
                KeychainManager.delete(key: "refreshToken")
                debugPrint("🔮 delete refreshToken")
            }
        }
    }
    
    var kakaoAccessToken: String? {
        get {
            guard let value = KeychainManager.load(key: "kakaoAccessToken"),
                  !value.isEmpty,
                  let token = String(data: value, encoding: String.Encoding.utf8) else {
                return nil
            }
            debugPrint("🔮 get kakaoAccessToken : \(token)")
            return token
        }
        set {
            if let value = newValue, let data = value.data(using: .utf8) {
                KeychainManager.save(key: "kakaoAccessToken", data: data)
                debugPrint("🔮 save kakaoAccessToken : \(value)")
            } else {
                KeychainManager.delete(key: "kakaoAccessToken")
                debugPrint("🔮 delete kakaoAccessToken")
            }
        }
    }
    
    func reset() {
        refreshToken = nil
        accessToken = nil
    }
}
