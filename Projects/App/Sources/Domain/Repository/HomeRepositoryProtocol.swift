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
    func getBannerList() async -> Result<[HomeBannerResonseDTO], NetworkError>
//    func tobeReleaseProduct() async -> Future<[HomeRolloutResponseDTO], NetworkError>
    func tobeReleaseProduct() async -> Future<[HomeRolloutResult], NetworkError>
    func homeCafe() async -> Future<[HomeCafeResponseDTO], NetworkError>
}
