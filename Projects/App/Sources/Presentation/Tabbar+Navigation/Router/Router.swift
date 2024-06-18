//
//  Router.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

public class Router: ObservableObject {
    public enum Route: Hashable, Identifiable {
        public var id: Self { self }
        
        case tabView
        case login
        case home
        case category
        case mypage
        case review
        case setting
    }
    
    @Published public var path: NavigationPath = NavigationPath()
    
    @ViewBuilder public func view(for route: Route) -> some View {
        switch route {
        case .tabView:
            TabbarMainView()
        case .login:
            Text("login")
        case .home:
            HomeView()
        case .category:
            CategoryView()
        case .mypage:
            MypageView()
        case .review:
            AnotherView()
        case .setting:
            Text("setting")
        }
    }
    
    public func navigateTo(_ page: Route) {
        path.append(page)
    }
    
    public func navigateBack() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func replaceNavigationStack(_ page: Route) {
        path.removeLast(path.count)
        path.append(page)
    }
}
