//
//  HomeRepository.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

class HomeRepository: HomeRepositoryProtocol {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getBannerList() -> Future<[HomeBannerResonseDTO], NetworkError> {
        return Future { promise in
//            let response: Result<[HomeBannerResonseDTO], NetworkError> = await self.apiService.request(
//                httpMethod: .get,
//                endPoint: APIEndPoint.url(for: .banner)
//            )
//            
//            switch response {
//            case .success(let success):
//                return .success(success)
//            case .failure(let error):
//                debugPrint("🏠 getBannerList error\(error.localizedDescription)")
//                return .failure(error)
//            }
        }
        
    }
    
    func tobeReleaseProduct() -> Future<[HomeRolloutResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[HomeRolloutResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .tobeReleased)
                )
                
                switch response {
                case .success(let data):
                    let mappedResults = data.map { HomeMapper.toRolloutResult(response: $0) }
                    promise(.success(mappedResults))
                case .failure(let error):
                    debugPrint("🏠🔴 tobeReleaseProduct failure \(error.localizedDescription)  🏠🔴")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
    
    func homeCafe() -> Future<[HomeCafeResult], NetworkError> {
        return Future { promise in
            Task {
                let response: Result<[HomeCafeResponseDTO], NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .homeCafe)
                )
                
                switch response {
                case .success(let data):
                    let mappedResults = data.map { HomeMapper.toCafeResult(response: $0) }
                    promise(.success(mappedResults))
                case .failure(let error):
                    debugPrint("🏠🔴 homeCafe failure \(error.localizedDescription) 🏠🔴")
                    promise(.failure(NetworkError.response))
                }
            }
        }
    }
}
