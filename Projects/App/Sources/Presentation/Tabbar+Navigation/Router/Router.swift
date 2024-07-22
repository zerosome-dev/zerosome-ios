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
        case login
        case term
        case nickname
        case tobeReleasedProduct(String, String) // 홈 > 종류별 더보기
        case categoryFilter(String)
        case detailMainView(String)
        case reviewList
        case creatReview
        case mypageReviewList
        case myReivew
        case mypgaeNickname
        case report
    }
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var defaultView: Tabbar = .home
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .tabView:
            TabbarMainView()
        case .login:
            LoginMainView()
        case .term:
            TermView()
        case .nickname:
            NicknameView()
        case .tobeReleasedProduct(let title, let subTitle):
            TobeReleasedProductView(title: title, subTitle: subTitle)
        case .categoryFilter(let type):
            CategoryFilteredView(type: type)
        case .detailMainView(let product):
//            @StateObject var viewModel = DetailMainViewModel()
            DetailMainView(product: product)
        case .reviewList:
            ReviewListView()
        case .creatReview:
            CreateReviewView()
        case .mypageReviewList:
            MyReviewsListView()
        case .myReivew:
            MyReivewView()
        case .mypgaeNickname:
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
