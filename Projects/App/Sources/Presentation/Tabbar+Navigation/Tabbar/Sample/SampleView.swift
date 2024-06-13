//
//  HomeView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: TabbarViewModel
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Text("Go TO CATEGORY VIEW")
                .onTapGesture {
                    viewModel.selected = .category
                }
                .foregroundStyle(.white)
        }
    }
}

struct CategoryView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: TabbarViewModel
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            Text("GO TO MYPAGEVIEW")
                .onTapGesture {
                    viewModel.selected = .mypage
                }
        }
    }
}

struct MypageView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: TabbarViewModel
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Text("GO TO Another View")
                .onTapGesture {
                    router.replaceNavigationStack(.review)
                }
        }
    }
}

#Preview {
    HomeView()
}
