//
//  FilterUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

struct FilterUsecase {
    let filterRepoProtocol: FilterRepositoryProtocol
    
    func getD1CategoryList(d1CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError> {
        return filterRepoProtocol.getD2CategoryList(d1CategoryCode: d1CategoryCode)
    }
    
    func getBrandList(d2CategoryCode: String?) -> Future<[BrandFilterResult], NetworkError> {
        return filterRepoProtocol.getBrandList(d2CategoryCode: d2CategoryCode)
    }
    
    func getZeroTagList() -> Future<[ZeroCategoryFilterResult], NetworkError> {
        return filterRepoProtocol.getZeroTagList()
    }
    
    func getFilterdProduct(
        offset: Int?,
        limit: Int?,
        d2CategoryCode: String,
        orderType: String?,
        brandList: [String]? = [],
        zeroCtgList: [String]? = []
    ) -> Future<OffsetFilteredProductResult, NetworkError> {
        return filterRepoProtocol.getFilterdProduct(
            offset: offset,
            limit: limit,
            d2CategoryCode: d2CategoryCode,
            orderType: orderType,
            brandList: brandList ?? [],
            zeroCtgList: zeroCtgList ?? []
        )
    }
}
