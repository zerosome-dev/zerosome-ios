//
//  Tabbar.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

enum Tabbar: CaseIterable {
    case home, category, mypage
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            RouterView {
                HomeView()
            }
        case .category:
            RouterView {
                CategoryView()
            }
        case .mypage:
            RouterView {
                MypageView()
            }
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
    
    var image: String {
        switch self {
        case .home:
            "house"
        case .category:
            "star.fill"
        case .mypage:
            "heart.fill"
        }
    }
}
