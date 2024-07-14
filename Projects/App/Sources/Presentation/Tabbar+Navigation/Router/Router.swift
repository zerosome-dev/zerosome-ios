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
        case homeSecondDepth(String, String) // 홈 > 종류별 더보기
        case categorySecondDepth(String)
        case categoryFilter
        case detailMainView
    }
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var defaultView: Tabbar = .home
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .tabView:
            TabbarMainView()
        case .homeSecondDepth(let title, let subTitle):
            HomeCategoryDetailView(title: title, subTitle: subTitle)
        case .categorySecondDepth(let type):
            CategoryFilteredView(type: type)
        case .categoryFilter:
            Text("카테고리 선택뷰")
        case .detailMainView:
//            @StateObject var viewModel = DetailMainViewModel()
            DetailMainView()
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
