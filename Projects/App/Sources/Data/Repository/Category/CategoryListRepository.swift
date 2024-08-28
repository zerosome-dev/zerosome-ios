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
    
    func getCategoryList() -> Future<[D1CategoryResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[D1CategoryResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .list)
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = data.map { CategoryMapper.toCategoryResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("CategoryList failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
    
    func getD2CategoryList(d2CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[D2CategoryFilterResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .d2CategoryList),
                    pathParameters: d2CategoryCode
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = data.map { CategoryMapper.toD2CategoryFilterResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("CategoryFilter Failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
    
    func getBrandList() -> Future<[BrandFilterResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[BrandFilterResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .brandList)
                )
                
                switch response {
                case .success(let success):
                    let mappedResult = success.map { CategoryMapper.toBrandResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("Brand List Filter Failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
        
    
    func getZeroTagList() -> Future<[ZeroCategoryFilterResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[ZeroCategoryFilterResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .zeroTagList)
                )
                
                switch response {
                case .success(let success):
                    let mappedResult = success.map { CategoryMapper.toZeoTagResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("ZeroTag List Filter Failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
}
