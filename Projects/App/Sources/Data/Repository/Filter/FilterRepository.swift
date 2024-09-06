//
//  FilterRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

final class FilterRepository: FilterRepositoryProtocol {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getD2CategoryList(d1CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[D2CategoryFilterResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .d2CategoryList),
                    pathParameters: d1CategoryCode,
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let data):
                    let mappedResult = data.map { FilterMapper.toD2CategoryFilterResult(response: $0) }
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
                    let mappedResult = success.map { FilterMapper.toBrandResult(response: $0) }
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
                    let mappedResult = success.map { FilterMapper.toZeroTagResult(response: $0) }
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("ZeroTag List Filter Failure \(failure.localizedDescription)")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }    
    
    func getFilterdProduct(offset: Int?, limit: Int?, d2CategoryCode: String, orderType: String?, brandList: [String]?, zeroCtgList: [String]?) -> Future<OffsetFilteredProductResult, NetworkError> {
        let parameters: [String : Int?] = ["offset" : offset ?? 0, "limit" : limit ?? 10]
        
        return Future { promise in
            Task {
                let response: Result<OffsetPageResponseDTO, NetworkError> = await self.apiService.request(
                    httpMethod: .post,
                    endPoint: APIEndPoint.url(for: .filteredProduct),
                    queryParameters: parameters,
                    pathParameters: d2CategoryCode,
                    body: ProductByCtgListRequest(
                        orderType: orderType,
                        brandList: brandList ?? [], //brandList.compactMap({ $0 }).isEmpty ? nil : brandList.compactMap({ $0 }),
                        zeroCtgList: zeroCtgList ?? [] //zeroCtgList.compactMap({ $0 }).isEmpty ? nil : zeroCtgList.compactMap({ $0 })
                    )
                )
                
                switch response {
                case .success(let success):
                    let mappedResult = FilterMapper.toFilteredProductResult(response: success)
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("Get Filtered ProudctList Failure \(failure.localizedDescription)🩵🩵🩵🩵🩵🩵")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
}

/*
 let response = await self.apiService.testApi(
     httpMethod: .post,
     endPoint: APIEndPoint.url(for: .filteredProduct),
     queryParameters: parameters,
     pathParameters: d2CategoryCode,
     body: ProductByCtgListRequest(
         orderType: orderType,
         brandList: brandList.compactMap({ $0 }).isEmpty ? nil : brandList.compactMap({ $0 }),
         zeroCtgList: zeroCtgList.compactMap({ $0 }).isEmpty ? nil : zeroCtgList.compactMap({ $0 })
     )
 )
 */
