//
//  ReviewDetailResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ReviewDetailResponseDTO: Decodable {
    var reviewId: Int?
    var rating: Double?
    var reviewContents: String?
    var regDate: String?
    var nickname: String?
}

struct ReviewListOffsetPageResponseDTO {
    var content: [ReviewDetailResponseDTO]?
    var limit: Int?
    var offset: Int?
}
