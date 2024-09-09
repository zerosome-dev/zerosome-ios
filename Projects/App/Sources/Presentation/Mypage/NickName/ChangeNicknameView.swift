//
//  ChangeNicknameView.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ChangeNicknameView: View {
    @ObservedObject var viewModel: ChangeNicknameViewModel
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var router: Router
    let nickname: String
    
    var body: some View {
        VStack {
            ZSText(
                "최소 2자 ~ 12자 이내의 닉네임을 입력해 주세요\n한글/영문/숫자/특수문자 모두 가능해요",
                fontType: .body2,
                color: Color.neutral500
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.init(top: 30,leading: 0,bottom: 43,trailing: 0))
            
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
            
            ZSText(
                viewModel.nicknameErrorMessage.rawValue,
                fontType: .body1,
                color: viewModel.isValid
                ? Color.positive
                : Color.negative
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            CommonButton(title: "닉네임 변경 완료", font: .subtitle1)
                .enable(viewModel.isValid)
                .tap {
                    viewModel.send(.changeNickname)
                }
                .onReceive(viewModel.$changeNicknameResult) { temp in
                    guard let result = temp else { return }
                    if result {
                        toast.settingToggle(type: .modiftyNickname)
                        toast.setToggle(for: .modiftyNickname, true)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            router.navigateBack()
                        }
                    } else {
                        toast.settingToggle(type: .failNickname)
                        toast.setToggle(for: .failNickname, true)
                    }
                }
        }
        .onAppear {
            viewModel.nickname = nickname
        }
        .padding(.horizontal, 22)
        .ZSNavigationBackButtonTitle("닉네임 변경") {
            router.navigateBack()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

//#Preview {
//    ChangeNicknameView(viewModel: ChangeNicknameViewModel(accountUseCase: AccountUseCase(accountRepoProtocol: AccountRepository(apiService: ApiService())), initialNickname: "닉네임"), nickname: "닉네임")
//}

