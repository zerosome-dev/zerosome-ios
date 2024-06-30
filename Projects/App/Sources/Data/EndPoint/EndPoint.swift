//
//  EndPoint.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct APIEndPoint {
    static let baseURL = ""
    
    enum Auth {
        case login
        case checkNickname
        case join
        case logout
    }
    
    enum Home {
        case product
    }
}
