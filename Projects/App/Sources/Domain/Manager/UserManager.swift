//
//  UserManager.swift
//  App
//
//  Created by 박서연 on 2024/08/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

final class UserManager {
    public static let shared = UserManager()
    
    private init() { }
    private var userId: Int?
    private var userNickname: String?
    
    public var id: Int? {
        get {
            return userId
        }
        set {
            userId = newValue
        }
    }
    
    public var nickname: String? {
        get {
            return userNickname
        }
        set {
            userNickname = newValue
        }
    }
}
