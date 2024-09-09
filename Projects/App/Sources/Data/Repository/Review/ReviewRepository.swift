//
//  ReviewRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

final class ReviewRepository: ReviewRepositoryProtocol {

    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getMyReviewList(offset: Int?, limit: Int?) -> Future<MypageOffsetPageResult, NetworkError> {
        let parameters: [String : Int?] = ["offset" : offset ?? 0, "limit" : limit ?? 10]
        
        return Future { promise in
            Task {
                let response: Result<MypageOffsetPageResponseDTO, NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .userReviewList),
                    queryParameters: parameters,
                    header: AccountStorage.shared.accessToken)
                
                switch response {
                case .success(let data):
                    let mappedResult = ReviewMapper.toMyReviewOffsetResult(response: data)//data.map { ReviewMapper.toMyReviewOffsetResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("ReviewRepo > Get user review list > failed \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
    
    func postReview(review: ReviewCreateRequest) -> Future<Bool, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<Bool, NetworkError> = await self.apiService.noneDecodeRequest(
                    httpMethod: .post,
                    endPoint: APIEndPoint.url(for: .reviewBase),
                    body: review,
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    debugPrint("리뷰 등록 성공")
                    promise(.success(success))
                case .failure(let failure):
                    debugPrint("리뷰 등록 실패\(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
    
    func productReviewList(productId: String, offset: Int?, limit: Int?) -> Future<ReviewOffsetPageResult, NetworkError> {
        let parameters: [String : Int?] = ["offset" : offset ?? 0, "limit" : limit ?? 10]

        return Future { promise in
            Task {
                let response: Result<ReviewListOffsetPageResponseDTO, NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .review),
                    queryParameters: parameters,
                    pathParameters: productId
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = ReviewMapper.toReviewList(response: data)
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("fail to get product review list \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
    
    func deleteReview(reviewId: Int) -> Future<Bool, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<Bool, NetworkError> = await self.apiService.noneDecodeRequest(
                    httpMethod: .delete,
                    endPoint: APIEndPoint.url(for: .reviewBase),
                    pathParameters: "\(reviewId)",
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    debugPrint("💩💩💩 success to delete review!!!!!\(success)")
                    promise(.success(success))
                case .failure(let failure):
                    debugPrint("delete review failed \(failure.localizedDescription)")
                    promise(.failure(.badRequest))
                }
            }
        }
    }
    
    func modifyReview(reviewId: Int, modifyReview: ReviewModifyRequest) -> Future<Bool, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<Bool, NetworkError> = await self.apiService.noneDecodeRequest(
                    httpMethod: .put,
                    endPoint: APIEndPoint.url(for: .reviewBase),
                    pathParameters: "\(reviewId)",
                    body: modifyReview,
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    debugPrint("💩💩 success to modify review!!!!\(success)")
                    promise(.success(success))
                case .failure(let failure):
                    debugPrint("delete review failed \(failure.localizedDescription)")
                    promise(.failure(.badRequest))
                }
            }
        }
    }
}
