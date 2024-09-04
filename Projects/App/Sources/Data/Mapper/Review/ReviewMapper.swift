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
            regDate: DateMapper.returnDate(response.regDate ?? ""),
            nickname: response.nickname ?? "")
    }
    
    static func toMyReviewOffsetResult(response: MypageOffsetPageResponseDTO) -> MypageOffsetPageResult {
        let content = response.content.map { dto in
            ReviewByMemberResult(
                memberId: dto.memberId ?? 0,
                nickname: dto.nickname ?? "",
                reviewCnt: dto.reviewCnt ?? 0,
                reviewList: (dto.reviewList ?? []).compactMap { dto in
                    ReviewDetailByMemberResult(
                        reviewId: dto.reviewId ?? 0,
                        rating: dto.rating ?? 0.0,
                        reviewContents: dto.reviewContents ?? "",
                        brand: dto.brand ?? "",
                        productName: dto.productName ?? "",
                        productImage: dto.productImage ?? "",
                        regDate: DateMapper.returnDate(dto.regDate ?? "")
                    )
                }
            )
        } ?? ReviewByMemberResult(memberId: 0, nickname: "", reviewCnt: 0, reviewList: [])
        
        return MypageOffsetPageResult(
            content: content,
            limit: response.limit ?? 10,
            offset: response.offset ?? 0
        )
    }
}
