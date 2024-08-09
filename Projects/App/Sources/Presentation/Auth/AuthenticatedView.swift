//
//  AuthenticatedView.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var viewModel = AuthViewModel(
        accountUseCase: AccountUseCase(
            accountRepoProtocol: AccountRepository(
                apiService: ApiService())
        ),
        socialUseCase: SocialUsecase(
            socialRepoProtocol: SocialRepository(
               )
        )
    )
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .initial:
                LoginMainView()
                    .environmentObject(viewModel)
            case .signIn:
                TabbarMainView()
                    .environmentObject(viewModel)
            case .nickname:
                NicknameView(authViewModel: viewModel)
                    .environmentObject(viewModel)
            case .term:
                TermView()
                    .environmentObject(viewModel)
            case .needToToken:
                LoginMainView()
                    .environmentObject(viewModel)
            }
        }
    }
}


#Preview {
    AuthenticatedView()
}
