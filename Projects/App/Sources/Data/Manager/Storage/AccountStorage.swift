//
//  AccountStorage.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

final class StorageKey {
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
    static let kakaoToken = "kakaoToken"
    static let appleToken = "appleToken"
}

final class AccountStorage {
    
    static var shared = AccountStorage()
    
    var isGuest: Bool? {
        return accessToken?.isEmpty ?? true
    }
    
    var accessToken: String? {
        get {
            guard let token = KeyChain.read(key: StorageKey.accessToken), !token.isEmpty else {
                return nil
            }
            
            debugPrint("🔮 get accessToken \(token)")
            return token
        }
        
        set {
            if let value = newValue {
                KeyChain.create(key: StorageKey.accessToken, token: value)
                debugPrint("🔮 save accessToken \(value)")
            } else {
                KeyChain.delete(key: StorageKey.accessToken)
                debugPrint("🔮 delete accessToken")
            }
        }
    }
    
    var refreshToken: String? {
        get {
            guard let token = KeyChain.read(key: StorageKey.refreshToken), !token.isEmpty else {
                return nil
            }
            
            debugPrint("🔮 get refreshToken \(token)")
            return token
        }
        
        set {
            if let value = newValue {
                KeyChain.create(key: StorageKey.refreshToken, token: value)
                debugPrint("🔮 save refreshToken \(value)")
            } else {
                KeyChain.delete(key: StorageKey.refreshToken)
                debugPrint("🔮 delete refreshToken")
            }
        }
    }
    
    var kakaoToken: String? {
        get {
            guard let token = KeyChain.read(key: StorageKey.kakaoToken), !token.isEmpty else {
                return nil
            }
            
            debugPrint("🔮 get kakaoToken \(token)")
            return token
        }
        
        set {
            if let value = newValue {
                KeyChain.create(key: StorageKey.kakaoToken, token: value)
                debugPrint("🔮 save kakaoToken \(value)")
            } else {
                KeyChain.delete(key: StorageKey.kakaoToken)
                debugPrint("🔮 delete kakaoToken")
            }
        }
    }
    
    var appleToken: String? {
        get {
            guard let token = KeyChain.read(key: StorageKey.appleToken), !token.isEmpty else {
                return nil
            }
            
            debugPrint("🔮 get appleToken \(token)")
            return token
        }
        
        set {
            if let value = newValue {
                KeyChain.create(key: StorageKey.appleToken, token: value)
                debugPrint("🔮 save appleToken \(value)")
            } else {
                KeyChain.delete(key: StorageKey.appleToken)
                debugPrint("🔮 delete appleToken")
            }
        }
    }
    
    func reset() {
        accessToken = nil
        refreshToken = nil
    }
}

final class KeyChain {
    
    class func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "🔮 Failed to save KeyChain!")
    }
    
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("🔮 Failed to read KeyChain!, Status Code = \(status)")
            return nil
        }
    }
    
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "🔮 Failed to delete KeyChain! Status code = \(status)")
    }
}
