//
//  JoinRequest.swift
//  App
//
//  Created by 박서연 on 2024/08/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct JoinRequest: Encodable {
    let nickname: String
    let marketing: Bool
}
