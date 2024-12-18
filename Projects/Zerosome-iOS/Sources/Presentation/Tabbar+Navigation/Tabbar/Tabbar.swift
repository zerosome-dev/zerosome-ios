//
//  Tabbar.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum Tabbar: CaseIterable {
    case home, category, mypage
    
    @ViewBuilder
    func view(with apiService: ApiService) -> some View {
        switch self {
        case .home:
            let homeRepoProtocol = HomeRepository(apiService: apiService)
            let homeUseCase = HomeUsecase(homeRepoProtocol: homeRepoProtocol)
            let filterRepo = FilterRepository(apiService: apiService)
            let filterUsecase = FilterUsecase(filterRepoProtocol: filterRepo)
            let viewModel = HomeMainViewModel(homeUsecase: homeUseCase, filterUsecase: filterUsecase)
            HomeMainView(viewModel: viewModel)
            
        case .category:
            let categoryRepoProtocol = CategoryListRepository(apiService: apiService)
            let categoryUseCase = CategoryUsecase(categoryRepoProtocol: categoryRepoProtocol)
            let viewModel = CategoryViewModel(categoryUseCase: categoryUseCase)
            CategoryMainView(viewModel: viewModel)
            
        case .mypage:
            let mypageRepo = MypageRepository(apiService: apiService)
            let mypageUsecase = MypageUsecase(mypageRepoProtocol: mypageRepo)
            let viewModel = MypageViewModel(mypageUseCase: mypageUsecase)
            MypageMainView(viewModel: viewModel)
        }
    }
    
    var title: String {
        switch self {
        case .home:
            "홈"
        case .category:
            "키테고리 검색"
        case .mypage:
            "마이페이지"
        }
    }
    
//    var image_default: Image {
//        switch self {
//        case .home:
//            ZerosomeTab.ic_home
//        case .category:
//            ZerosomeTab.ic_category
//        case .mypage:
//            ZerosomeTab.ic_mypage
//        }
//    }
    
    var image_fill: Image {
        switch self {
        case .home:
            ZerosomeTab.ic_home_fill
        case .category:
            ZerosomeTab.ic_category_fill
        case .mypage:
            ZerosomeTab.ic_mpyage_fill
        }
    }
}
