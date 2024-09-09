//
//  ReviewRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

protocol ReviewRepositoryProtocol {
    func getMyReviewList(offset: Int?, limit: Int?) -> Future<MypageOffsetPageResult, NetworkError>
    func postReview(review: ReviewCreateRequest) -> Future<Bool, NetworkError>
    func productReviewList(productId: String, offset: Int?, limit: Int?) -> Future<ReviewOffsetPageResult, NetworkError>
    func deleteReview(reviewId: Int) -> Future<Bool, NetworkError>
    func modifyReview(reviewId: Int, modifyReview: ReviewModifyRequest) -> Future<Bool, NetworkError>
}
