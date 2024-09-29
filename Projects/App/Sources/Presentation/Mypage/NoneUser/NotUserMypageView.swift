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
    var body: some View {
        VStack {
            ZSText("마이페이지", fontType: .heading1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
            
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
                                debugPrint("apple Login")
                            case .kakao:
                                debugPrint("kakao Login")
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
