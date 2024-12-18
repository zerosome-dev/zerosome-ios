//
//  NotUserMypageView.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct NotUserMypageView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            ZSText("아직 제로섬의 회원이 아니신가요?\n로그인 후, 더 많은 제로 식품을 탐색해 보세요!", fontType: .subtitle1)
                .multilineTextAlignment(.center)
            Spacer()
            VStack(spacing: 12) {
                ForEach(Login.allCases, id:\.self) { type in
                    LoginButton(type: type)
                        .onTapGesture {
                            switch type {
                            case .apple:
                                authViewModel.loginType = .apple
                                authViewModel.send(action: .appleSignIn)
                            case .kakao:
                                authViewModel.loginType = .kakao
                                authViewModel.send(action: .kakaoSignIn)
                            }
                        }
                }
            }
            .padding(.bottom, 42)
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    NotUserMypageView()
}
