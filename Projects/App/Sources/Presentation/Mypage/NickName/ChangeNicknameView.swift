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
            Text("최소 2자 ~ 12자 이내의 닉네임을 입력해 주세요\n한글/영문/숫자/특수문자 모두 가능해요")
                .foregroundStyle(Color.neutral500)
                .applyFont(font: .body2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                .padding(.bottom, 43)
            
            TextInput(text: $viewModel.nickname)
                .placeholder("닉네임을 입력해 주세요")
                .maxCount(12)
                .setError(
                    viewModel.isValid
                )
                .padding(.bottom, 4)
            
            if viewModel.isValid {
                Text("사용 가능한 닉네임입니다.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .applyFont(font: .body4)
                    .foregroundStyle(Color.positive)
                    .padding(.leading, 12)
            } else {
                Text("이미 사용중인 닉네임입니다.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .applyFont(font: .body4)
                    .foregroundStyle(Color.negative)
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
    NavigationStack {
        ChangeNicknameView()
    }
}
