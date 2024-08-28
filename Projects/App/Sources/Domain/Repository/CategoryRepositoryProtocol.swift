//
//  CategoryRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import SwiftUI

protocol CategoryRepositoryProtocol {
    func getCategoryList() -> Future<[D1CategoryResult], NetworkError>
    func getD2CategoryList(d2CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError>
    func getBrandList() -> Future<[BrandFilterResult], NetworkError>
    func getZeroTagList() -> Future<[ZeroCategoryFilterResult], NetworkError>
}
