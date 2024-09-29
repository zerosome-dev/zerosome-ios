//
//  HomeUsecase.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

struct HomeUsecase {
    let homeRepoProtocol: HomeRepositoryProtocol
    
//    func getBannerList()  -> Result<[HomeBannerResonseDTO], NetworkError> {
//        return homeRepoProtocol.getBannerList()
//    }
    
    func tobeReleaseProduct() -> Future<[HomeRolloutResult], NetworkError> {
        return homeRepoProtocol.tobeReleaseProduct()
    }
    
    func homeCafe() -> Future<[HomeCafeResult], NetworkError> {
        return homeRepoProtocol.homeCafe()
    }
}
