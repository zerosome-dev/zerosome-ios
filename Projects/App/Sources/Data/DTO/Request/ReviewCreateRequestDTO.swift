//
//  ReviewCreateRequestDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ReviewCreateRequest: Encodable {
    var productId: Int
    var rating: Double
    var contents: String
}
