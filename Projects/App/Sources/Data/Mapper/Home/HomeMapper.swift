//
//  HomeMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class HomeMapper {
    static func toCafeResult(response: HomeCafeResponseDTO) -> HomeCafeResult {
        return HomeCafeResult(
            id: response.id ?? 0,
            image: response.image ?? "",
            d1CategoryId: response.d1CategoryId ?? "",
            d2CategoryId: response.d2CategoryId ?? "",
            name: response.name ?? "",
            brand: response.brand ?? "",
            review: response.review ?? 0,
            reviewCnt: response.reviewCnt ?? 0)
    }
    
    static func toRolloutResult(response: HomeRolloutResponseDTO) -> HomeRolloutResult {
        return HomeRolloutResult(
            id: response.id ?? 0,
            image: response.image ?? "",
            d1Category: response.d1Category ?? "",
            d2Category: response.d2Category ?? "",
            name: response.name ?? "",
            salesStore: (response.salesStore ?? []).compactMap { $0 })
    }
}
