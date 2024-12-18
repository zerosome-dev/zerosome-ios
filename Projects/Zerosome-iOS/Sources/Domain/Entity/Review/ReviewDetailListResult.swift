//
//  ReviewDetailListResult.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ReviewDetailResult: Identifiable, Hashable {
    var reviewId: Int
    var rating: Double
    var reviewContents: String
    var regDate: String
    var nickname: String
    var more: Bool = false
    
    var id: String {
        return String(reviewId)
    }
}

// 리뷰 목록 + 페이지네이션
struct ReviewOffsetPageResult {
    var content: [ReviewDetailResult]
    var limit: Int
    var offset: Int
}

