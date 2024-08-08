//
//  KeychainManager.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Security

final class KeychainManager {
//    static let shared = KeychainManager()
    
    static func save(key: String, data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    static func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }

    static func delete(key: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}

//protocol KeychainManagerProtocol {
//    func save(key: String, data: Data)
//    func load(key: String) -> Data?
//    func delete(key: String)
//}
//
//final class KeychainManager: KeychainManagerProtocol {
//    
//    static let shared = KeychainManager()
//    
//    enum KeychainError: Error {
//        case noData
//    }
//    
//    static func save(key: String, data: Data) {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword as String,
//            kSecAttrAccount as String: key,
//            kSecValueData as String: data
//        ]
//
//        SecItemAdd(query as CFDictionary, nil)
//    }
//    
//    static func load(key: String) -> Data? {
//        let query = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key,
//            kSecReturnData as String: kCFBooleanTrue!,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ] as [String: Any]
//        
//        var dataTypeRef: AnyObject? = nil
//        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
//        
//        if status == noErr {
//            return dataTypeRef as? Data
//        } else {
//            return nil
//        }
//    }
//    
//    static func delete(key: String) {
//        let query = [
//            kSecClass as String: kSecClassGenericPassword as String,
//            kSecAttrAccount as String: key
//        ]
//
//        SecItemDelete(query as CFDictionary)
//    }
//}
