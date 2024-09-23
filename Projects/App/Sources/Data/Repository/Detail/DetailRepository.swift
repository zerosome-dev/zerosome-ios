//
//  DetailRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

class DetailRepository: DetailRepositoryProtocol {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getProductDetail(_ productId: Int) -> Future<ProductDetailResponseResult, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<ProductDetailResponseDTO, NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .detail),
                    pathParameters: "\(productId)"
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = DetailMapper.toDetailResult(response: data)
                    promise(.success(mappedResult))
                case .failure(let failure):
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
}
