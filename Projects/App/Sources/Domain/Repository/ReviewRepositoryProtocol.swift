//
//  ReviewRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

protocol ReviewRepositoryProtocol {
    func getMyReviewList(offset: Int?, limit: Int?) -> Future<[MypageOffsetPageResult], NetworkError>
    func postReview(review: ReviewCreateRequest) -> Future<Bool, NetworkError>
}
