//
//  MyReviewListResult.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

// MARK: - 유저 작성 리뷰 목록 조회 api

struct MypageOffsetPageResult {
    var content: ReviewByMemberResult
    var limit: Int
    var offset: Int
}

struct ReviewByMemberResult: Identifiable {
    var memberId: Int
    var nickname: String
    var reviewCnt: Int
    var reviewList: [ReviewDetailByMemberResult]
    
    var id = UUID().uuidString
}

struct ReviewDetailByMemberResult: Hashable, Equatable, Identifiable {
    var reviewId: Int
    var rating: Double
    var contents: String
    var brandName: String
    var productName: String
    var productImage: String
    var regDate: String
    
    var id = UUID().uuidString
}
