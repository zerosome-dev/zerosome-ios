//
//  CategoryListRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

final class CategoryListRepository: CategoryRepositoryProtocol {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getCategoryList() async -> Future<[D1CategoryResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[D1CategoryResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .list)
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = data.map { CategoryMapper.toCategoryList(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("CategoryList failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
    
}
