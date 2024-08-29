//
//  ReviewMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class ReviewMapper {
    static func toReviewDetailResult(response: ReviewDetailResponseDTO) -> ReviewDetailResult {
        return ReviewDetailResult(
            reviewId: response.reviewId ?? 0,
            rating: response.rating ?? 0.0,
            reviewContents: response.reviewContents ?? "",
            regDate: response.regDate ?? .init(),
            nickname: response.nickname ?? "")
    }
    
//    static func toReviewOffsetResult(response: ReviewListOffsetPageResponseDTO) -> ReviewOffsetPageResult {
//        return ReviewOffsetPageResult(
//            content: (response.content).compactMap { dto in
//                        guard let reviewId = dto.reviewId,
//                              let rating = dto.rating,
//                              let reviewContents = dto.reviewContents,
//                              let regDate = dto.regDate,
//                              let nickname = dto.nickname else {
//                            return nil
//                        }
//                        return ReviewDetailResult(
//                            reviewId: reviewId,
//                            rating: rating,
//                            reviewContents: reviewContents,
//                            regDate: regDate,
//                            nickname: nickname
//                        )
//                    },
//            limit: response.limit ?? 0,
//            offset: response.offset ?? 0)
//    }
}

//MypageOffsetPageResult ReviewMyMemberResult ReviewDetailByMemberResult
