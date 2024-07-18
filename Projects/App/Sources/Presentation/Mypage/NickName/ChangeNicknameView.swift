//
//  ChangeNicknameView.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

class ChangeNicknameViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var isValid: Bool = false
    // init에서 원래 닉네음으로 초기화
    
    func checkNickName(completion: @escaping (Bool) -> Void) {
        // 닉네임 중복체크
    }
}

struct ChangeNicknameView: View {
    @StateObject private var viewModel = ChangeNicknameViewModel()
    
    var body: some View {
        VStack {
            ZSText("최소 2자 ~ 12자 이내의 닉네임을 입력해 주세요\n한글/영문/숫자/특수문자 모두 가능해요", fontType: .body2, color: Color.neutral500)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 30,leading: 0,bottom: 43,trailing: 0))
            
            TextInput(text: $viewModel.nickname)
                .placeholder("닉네임을 입력해 주세요")
                .maxCount(12)
                .setError(
                    viewModel.isValid
                )
                .overlay(alignment: .trailing) {
                    // TODO: - 이미지 변경
                    Text("..")
                        .offset(x: -22)
                }
                .padding(.bottom, 4)
            
            if viewModel.isValid {
                ZSText("사용 가능한 닉네임입니다.", fontType: .body4, color: Color.positive)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
            } else {
                ZSText("이미 사용중인 닉네임입니다.", fontType: .body4, color: Color.negative)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
            }
            Spacer()
            CommonButton(title: "닉네임 변경 완료", font: .subtitle1)
                .enable(!viewModel.nickname.isEmpty)
        }
        .padding(.horizontal, 22)
        .ZSNavigationBackButtonTitle("닉네임 변경") {
            print("닉네임 변경 취소")
        }
    }
}

#Preview {
    ChangeNicknameView()
}
