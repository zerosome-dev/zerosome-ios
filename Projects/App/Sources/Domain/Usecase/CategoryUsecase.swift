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
    
    func getCategoryList() async -> Future<[D1CategoryResult], NetworkError> {
        return await categoryRepoProtocol.getCategoryList()
    }
}
