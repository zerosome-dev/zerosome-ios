//
//  Router.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable, Identifiable {
        var id: Self { self }

        case tabView
        case tobeReleasedProduct([HomeRolloutResult], String, String) // 홈 > 종류별 더보기
        case categoryFilter(String, String, [String]) // navigationTitle, d2CategoryCode, brandFilterforCafe
        case detailMainView(Int)
        case reviewList(String, ReviewEntity)
        case creatReview(ReviewEntity) // proudct it, name, brand
        case mypageReviewList
        case myReivew(ReviewDetailByMemberResult)
        case mypgaeNickname(String) // nickname
        case report
    }
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var defaultView: Tabbar = .home
    
    @ViewBuilder func view(for route: Route, with apiService: ApiService, toast: ToastAction) -> some View {
        switch route {
        case .tabView:
            TabbarMainView(apiService: apiService)
            
        case .tobeReleasedProduct(let releasedArray, let title, let subTitle):
            TobeReleasedProductView(title: title, subTitle: subTitle, data: releasedArray)
            
        case .categoryFilter(let filteredTitle, let d2CategoryCode, let brandFilterForCafe):
            let filterRepo = FilterRepository(apiService: apiService)
            let filterUsecase = FilterUsecase(filterRepoProtocol: filterRepo)
            let viewModel = CategoryFilteredViewModel(filterUsecase: filterUsecase)
            CategoryFilteredView(navigationTtile: filteredTitle, d2CategoryCode: d2CategoryCode, viewModel: viewModel)

        case .detailMainView(let productId):
            DetailMainView(productId: productId)
        
        case .reviewList(let productId, let reviewEntity):
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = ReviewListViewModel(reviewUsecase: reviewUsecase)
            ReviewListView(viewModel: viewModel, productId: productId, reviewEntity: reviewEntity)
        
        case .creatReview(let data):
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = CreateReviewViewModel(reviewUsecase: reviewUsecase)
//            let viewModel = MyReviewsListViewModel(reviewUsecase: reviewUsecase)
            CreateReviewView(data: data, viewModel: viewModel)
        
        case .mypageReviewList:
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = MyReviewsListViewModel(reviewUsecase: reviewUsecase)
            MyReviewsListView(viewModel: viewModel)
        
        case .myReivew(let review):
            let viewModel = MyReivewViewModel(review: review)
            MyReivewView(viewModel: viewModel)
        
        case .mypgaeNickname(let nickname):
            ChangeNicknameView()
        
        case .report:
            ReportMainView()
        }
    }
    
    func navigateTo(_ page: Route) {
        path.append(page)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func replaceNavigationStack(_ page: Route) {
        path.removeLast(path.count)
        path.append(page)
    }
}
