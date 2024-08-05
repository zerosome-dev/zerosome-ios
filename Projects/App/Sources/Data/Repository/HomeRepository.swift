//
//  HomeRepository.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class HomeRepository: HomeRepositoryProtocol {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getBannerList() async -> Result<[HomeBannerResonseDTO], NetworkError> {
        let response: Result<[HomeBannerResonseDTO], NetworkError> = await apiService.request(
            httpMethod: .get,
            endPoint: APIEndPoint.url(for: .banner) 
        )
        
        switch response {
        case .success(let success):
            return .success(success)
        case .failure(let error):
            debugPrint("🏠 getBannerList error\(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func tobeReleaseProduct() async -> Result<[HomeRolloutResponseDTO], NetworkError> {
        return .success([])
    }
    
    func homeCafe() async -> Result<[HomeCafeResponseDTO], NetworkError> {
        return .success([])
    }
}
