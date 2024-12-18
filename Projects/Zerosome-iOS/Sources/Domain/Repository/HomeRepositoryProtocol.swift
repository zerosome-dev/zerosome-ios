//
//  HomeRepositoryRepoInterface.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol {
    func getBannerList() -> Future<[HomeBannerResonseDTO], NetworkError>
    func tobeReleaseProduct() -> Future<[HomeRolloutResult], NetworkError>
    func homeCafe() -> Future<[HomeCafeResult], NetworkError>
}
