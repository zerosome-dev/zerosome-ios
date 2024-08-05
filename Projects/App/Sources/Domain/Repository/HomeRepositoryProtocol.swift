//
//  HomeRepositoryRepoInterface.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getBannerList() async -> Result<[HomeBannerResonseDTO], NetworkError>
    func tobeReleaseProduct() async -> Result<[HomeRolloutResponseDTO], NetworkError>
    func homeCafe() async -> Result<[HomeCafeResponseDTO], NetworkError>
}
