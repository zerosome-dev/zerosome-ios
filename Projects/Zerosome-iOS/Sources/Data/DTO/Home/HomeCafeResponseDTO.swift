//
//  HomeCafeResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeCafeResponseDTO: Decodable {
    var id: Int?
    var image: String?
    var d1CategoryId: String?
    var d2CategoryId: String?
    var name: String?
    var brand: String?
    var review: Double?
    var reviewCnt: Int?
}
