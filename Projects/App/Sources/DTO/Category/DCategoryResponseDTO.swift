//
//  DCategoryResponse.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct D1CategoryResponseDTO: Decodable {
    var d1CategoryCode: String?
    var d1CategoryName: String?
    var d2Category: [D2CategoryResponseDTO]?
}

struct D2CategoryResponseDTO: Decodable {
    var d2CategoryCode: String?
    var d2CategoryName: String?
    var d2CategoryImage: String?
    var noOptionYn: Bool
}
