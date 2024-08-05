//
//  TabbarMainView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct TabbarMainView: View {
    @StateObject var viewModel = TabbarViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
            TabbarView(viewModel: viewModel)
//            .overlay(alignment: .bottom) {
//                TabbarView(viewModel: viewModel)
//                    .ignoresSafeArea(edges: .bottom)
//            }
        }
    }
}

struct AuthenticationView: View {
    @StateObject private var authViewModel = AuthViewModel(
        accountUseCase: AccountUseCase(
            accountRepoProtocol: AccountRepository(
                apiService: ApiService())
        ),
        socialUseCase: SocialUsecase(
            socialRepoProtocol: SocialRepository()
        )
    )
    
    @StateObject private var viewModel = TabbarViewModel()
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .initial:
                LoginMainView(authViewModel: authViewModel)
            case .signIn:
                VStack(spacing: 0) {
                    TabView(selection: $viewModel.selected) {
                        ForEach(Tabbar.allCases, id: \.self) { tab in
                            tab.view
                        }
                        .toolbarBackground(.hidden, for: .tabBar)
                    }
                    TabbarView(viewModel: viewModel)
                }
            case .nickname:
                NicknameView(authViewModel: authViewModel)
            case .term:
                TermView(authViewModel: authViewModel)
            case .needToToken:
                EmptyView()
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
