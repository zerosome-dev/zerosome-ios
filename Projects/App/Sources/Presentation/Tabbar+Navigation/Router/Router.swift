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
        case categoryFilter(String, String, String) // navigationTitle, d2CategoryCode, d1categorydCode
        case detailMainView(Int, String)
        case reviewList(String, ReviewEntity)
        case creatReview(ReviewEntity) // proudct it, name, brand
        case mypageReviewList
        case myReivew(ReviewDetailByMemberResult)
        case mypgaeNickname(String) // nickname
        case report
    }
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var defaultView: Tabbar = .home
    
    @ViewBuilder func view(for route: Route, with apiService: ApiService, toast: ToastAction, auth: AuthViewModel) -> some View {
        switch route {
        case .tabView:
            TabbarMainView(apiService: apiService)
            
        case .tobeReleasedProduct(let releasedArray, let title, let subTitle):
            TobeReleasedProductView(title: title, subTitle: subTitle, data: releasedArray)
            
        case .categoryFilter(let filteredTitle, let d2CategoryCode, let d1CategoryCode):
            let filterRepo = FilterRepository(apiService: apiService)
            let filterUsecase = FilterUsecase(filterRepoProtocol: filterRepo)
            let viewModel = CategoryFilteredViewModel(initD2CategoryCode: d2CategoryCode, initD1CategoryCode: d1CategoryCode, filterUsecase: filterUsecase)
            CategoryFilteredView(viewModel: viewModel, navigationTtile: filteredTitle, d2CategoryCode: d2CategoryCode, d1CategoryCode: d1CategoryCode)

        case .detailMainView(let productId, let navigationTitle):
            let detailRepo = DetailRepository(apiService: apiService)
            let detailUsecase = DetailUsecase(detailRepoProtocol: detailRepo)
            let viewModel = DetailMainViewModel(detailUseCase: detailUsecase)
            DetailMainView(navigationTitle: navigationTitle, productId: productId, viewModel: viewModel)
                .environmentObject(auth)
        
        case .reviewList(let productId, let reviewEntity):
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = ReviewListViewModel(reviewUsecase: reviewUsecase)
            ReviewListView(viewModel: viewModel, productId: productId, reviewEntity: reviewEntity)
                .environmentObject(auth)
            
        case .creatReview(let data):
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = CreateReviewViewModel(reviewUsecase: reviewUsecase)
            CreateReviewView(data: data, viewModel: viewModel)
        
        case .mypageReviewList:
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = MyReviewsListViewModel(reviewUsecase: reviewUsecase)
            MyReviewsListView(viewModel: viewModel)
                .environmentObject(auth)
            
        case .myReivew(let review):
            let reviewRepo = ReviewRepository(apiService: apiService)
            let reviewUsecase = ReviewUsecase(reviewProtocol: reviewRepo)
            let viewModel = MyReivewViewModel(reviewUsecase: reviewUsecase)
            MyReivewView(viewModel: viewModel, review: review)
                .environmentObject(auth)
        
        case .mypgaeNickname(let nickname):
            let accountRepo = AccountRepository(apiService: apiService)
            let accountUsecase = AccountUseCase(accountRepoProtocol: accountRepo)
            let viewModel = ChangeNicknameViewModel(accountUseCase: accountUsecase, initialNickname: nickname)
            ChangeNicknameView(viewModel: viewModel, nickname: nickname)
        
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
