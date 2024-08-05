//
//  HomeUsecase.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeUsecase {
    let homeRepoProtocol: HomeRepositoryProtocol
    
    func getBannerList() async  -> Result<[HomeBannerResonseDTO], NetworkError> {
        return await homeRepoProtocol.getBannerList()
    }
    
    func tobeReleaseProduct() async -> Result<[HomeRolloutResponseDTO], NetworkError> {
        return await homeRepoProtocol.tobeReleaseProduct()
    }
    
    func homeCafe() async -> Result<[HomeCafeResponseDTO], NetworkError> {
        return await homeRepoProtocol.homeCafe()
    }
}
