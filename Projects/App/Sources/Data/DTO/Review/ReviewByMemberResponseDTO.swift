//
//  ReviewByMemberResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

// 마이페이지 > 유저 작성 리뷰 목록 조회 DTO
struct MypageOffsetPageResponseDTO: Decodable {
    var content: ReviewByMemberResponseDTO?
    var limit: Int?
    var offset: Int?
}

struct ReviewByMemberResponseDTO: Decodable {
    var memberId: Int?
    var nickname: String?
    var reviewCnt: Int?
    var reviewList: [ReviewDetailByMemberResponseDTO]?
}

struct ReviewDetailByMemberResponseDTO: Decodable {
    var reviewId: Int?
    var rating: Double?
    var contents: String?
    var brandName: String?
    var productName: String?
    var productImage: String?
    var regDate: String?
}
