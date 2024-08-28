//
//  CategoryUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

struct CategoryUsecase {
    let categoryRepoProtocol: CategoryRepositoryProtocol
    
    func getCategoryList() -> Future<[D1CategoryResult], NetworkError> {
        return categoryRepoProtocol.getCategoryList()
    }
    
    func getD2CategoryList(d2CategoryCode: String) -> Future<[D2CategoryFilterResult], NetworkError> {
        return categoryRepoProtocol.getD2CategoryList(d2CategoryCode: d2CategoryCode)
    }
    
    func getBrandList() -> Future<[BrandFilterResult], NetworkError> {
        return categoryRepoProtocol.getBrandList()
    }
    
    func getZeroTagList() -> Future<[ZeroCategoryFilterResult], NetworkError> {
        return categoryRepoProtocol.getZeroTagList()
    }
}
