//
//  AuthenticatedView.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var viewModel: AuthViewModel
    let accountUseCase: AccountUseCase
    let socialUseCase: SocialUsecase
    let apiService: ApiService
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .splash:
                AppSplashView()
                    .onAppear {
                        viewModel.send(action: .checkToken)
                    }
            case .initial:
                LoginMainView()
                    .environmentObject(viewModel)
            case .signIn:
                TabbarMainView(apiService: apiService)
                    .environmentObject(viewModel)
            case .nickname:
                NicknameView(
                    viewModel: NicknameViewModel(
                        authViewModel: viewModel,
                        accountUseCase: accountUseCase
                    )
                )
                .environmentObject(viewModel)
            case .term:
                TermView()
                    .environmentObject(viewModel)
            case .needToToken:
                LoginMainView()
                    .environmentObject(viewModel)
            case .guest:
                TabbarMainView(apiService: apiService)
                    .environmentObject(viewModel)
            }
        }
    }
}
