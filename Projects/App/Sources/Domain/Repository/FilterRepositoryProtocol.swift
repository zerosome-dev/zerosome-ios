//
//  FilterRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

protocol FilterRepositoryProtocol {
    func getD2CategoryList(d1CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError>
    func getBrandList(d2CategoryCode: String?) -> Future<[BrandFilterResult], NetworkError>
    func getZeroTagList() -> Future<[ZeroCategoryFilterResult], NetworkError>
    func getFilterdProduct(offset: Int?, limit: Int?, d2CategoryCode: String, orderType: String?, brandList: [String]?, zeroCtgList: [String]?) -> Future<OffsetFilteredProductResult, NetworkError>
}
