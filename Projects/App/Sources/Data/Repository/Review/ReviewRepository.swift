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
    
    func getMyReviewList(offset: Int?, limit: Int?) -> Future<[MypageOffsetPageResult], NetworkError> {
        let parameters: [String : Int?] = ["offset" : offset ?? 0, "limit" : limit ?? 10]
        
        return Future { promise in
            Task {
                let response: Result<[MypageOffsetPageResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .userReviewList),
                    queryParameters: parameters,
                    header: AccountStorage.shared.accessToken)
                
                switch response {
                case .success(let data):
                    let mappedResult = data.map { ReviewMapper.toMyReviewOffsetResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("ReviewRepo > Get user review list > failed \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
}
