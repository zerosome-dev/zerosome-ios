//
//  NicknameView.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//
import DesignSystem
import SwiftUI

class NicknameViewModel: ObservableObject {
    @Published var isValid: Bool = false
 
    func checkNickName(completion: @escaping (Bool) -> Void) {
        // 닉네임 중복체크
    }
}

struct NicknameView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel = NicknameViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("닉네임을 설정해 주세요")
                .applyFont(font: .heading1)
            Text("최소 2자 ~ 12자 이내의 닉네임을 입력해 주세요\n한글/영문/숫자/특수문자 모두 가능해요")
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
            
            Spacer().frame(height: 24)
            
            TextInput(text: $text)
                .placeholder("닉네임을 입력해 주세요")
                .maxCount(12)
                .setError(
                    // TODO: - 서버 통신 및 에러 문구 타이밍 의논
                    viewModel.isValid
                )
                .padding(.bottom, 4)
            
            if viewModel.isValid {
                Text("사용 가능한 닉네임입니다.")
                    .applyFont(font: .body4)
                    .foregroundStyle(Color.positive)
                    .padding(.leading, 12)
            } else {
                Text("이미 사용중인 닉네임입니다.")
                    .applyFont(font: .body4)
                    .foregroundStyle(Color.negative)
                    .padding(.leading, 12)
            }
                
            Spacer()
            
            CommonButton(title: "회원가입 완료", font: .subtitle1)
                .enable(viewModel.isValid)
                .tap {
                    router.navigateTo(.tabView)
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .ZSnavigationBackButton {
            print("back")
        }
    }
}

//#Preview {
//    NicknameView(authViewModel: AuthViewModel(
//        authUseCase: SignInUseCase(
//            signInRepoProtocol: SignInRepository()
//        ))
//    )
//}
