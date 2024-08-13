//
//  NicknameView.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//
import Combine
import DesignSystem
import SwiftUI

struct NicknameView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel: NicknameViewModel
    
    init(authViewModel: AuthViewModel) {
        _viewModel = StateObject(
            wrappedValue: NicknameViewModel(
                authViewModel: authViewModel,
                accountUseCase: AccountUseCase(
                    accountRepoProtocol: AccountRepository(
                        apiService: ApiService())
                )
            ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("닉네임을 설정해 주세요")
                .applyFont(font: .heading1)
            Text("최소 2자 ~ 12자 이내의 닉네임을 입력해 주세요\n한글/영문/숫자/특수문자 모두 가능해요")
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
            
            Spacer().frame(height: 24)
            
            TextInput(text: $viewModel.nickname)
                .placeholder("닉네임을 입력해 주세요")
                .maxCount(12)
                .overlay(alignment: .trailing) {
                    ZerosomeAsset.ic_xmark
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.nickname = ""
                            viewModel.isValid = false
                        }
                }
                .padding(.bottom, 4)
            
            ZSText(viewModel.nicknameErrorMessage.rawValue,
                   fontType: .body1,
                   color: viewModel.isValid
                   ? Color.positive
                   : Color.negative)
            
            Spacer()
            
            CommonButton(title: "회원가입 완료", font: .subtitle1)
                .enable(viewModel.isValid)
                .tap {
                    guard let type = authViewModel.loginType else { return }
                    
                    switch type {
                    case .kakao:
                        viewModel.send(action: .signUpKakao)
                    case .apple:
                        viewModel.send(action: .signUpApple)
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .ZSnavigationBackButton {
            authViewModel.authenticationState = .term
        }
        .onAppear {
            print("SY))) marketing!!!! \(authViewModel.marketingAgreement)")
        }
    }
}

#Preview {
    NicknameView(authViewModel: AuthViewModel(
        accountUseCase: AccountUseCase(
            accountRepoProtocol: AccountRepository(
                apiService: ApiService())
        ),
        socialUseCase: SocialUsecase(
            socialRepoProtocol: SocialRepository(apiService: ApiService())
        )
    ))
}
