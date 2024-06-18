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
    
    var image_default: Image {
        switch self {
        case .home:
            ZerosomeTab.ic_home
        case .category:
            ZerosomeTab.ic_category
        case .mypage:
            ZerosomeTab.ic_mypage
        }
    }
    
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
