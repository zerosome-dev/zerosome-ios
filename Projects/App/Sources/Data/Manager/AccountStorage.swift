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
            guard let value = KeychainManager.shared.load(key: "accessToken"),
                  !value.isEmpty,
                  let token = String(data: value, encoding: String.Encoding.utf8) else {
                return nil
            }
            debugPrint("🔮 get accessToken : \(token)")
            return token
        }
        set {
            if let value = newValue, let data = value.data(using: .utf8) {
                KeychainManager.shared.save(key: "accessToken", data: data)
                debugPrint("🔮 save accessToken : \(value)")
            } else {
                KeychainManager.shared.delete(key: "accessToken")
                debugPrint("🔮 delete accessToken")
            }
        }
    }
    var refreshToken: String? {
        get {
            guard let value = KeychainManager.shared.load(key: "refreshToken"),
                  !value.isEmpty,
                  let token = String(data: value, encoding: String.Encoding.utf8) else {
                return nil
            }
            debugPrint("🔮 get refreshToken : \(token)")
            return token
        }
        set {
            if let value = newValue, let data = value.data(using: .utf8) {
                KeychainManager.shared.save(key: "refreshToken", data: data)
                debugPrint("🔮 save refreshToken : \(value)")
            } else {
                KeychainManager.shared.delete(key: "refreshToken")
                debugPrint("🔮 delete refreshToken")
            }
        }
    }
    
    func reset() {
        refreshToken = nil
        accessToken = nil
    }
}
