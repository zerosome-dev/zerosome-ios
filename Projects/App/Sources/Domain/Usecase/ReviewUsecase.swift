//
//  ReviewUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

struct ReviewUsecase {
    
    let reviewProtocol: ReviewRepositoryProtocol
    
    func getMyReviewList(offset: Int?, limit: Int?) -> Future<[MypageOffsetPageResult], NetworkError> {
        return reviewProtocol.getMyReviewList(offset: offset, limit: limit)
    }
    
    func postReview(review: ReviewCreateRequest) -> Future<Bool, NetworkError> {
        return reviewProtocol.postReview(review: review)
    }
    
    func getProductReviewList(productId: String, offset: Int?, limit: Int?) -> Future<[ReviewDetailResult], NetworkError> {
        return reviewProtocol.productReviewList(productId: productId, offset: offset, limit: limit)
    }
}
