//
//  MypageMainView.swift
//  App
//
//  Created by 박서연 on 2024/07/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

struct MypageMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: MypageViewModel
    
    var body: some View {
        ScrollView {
            UserInfoView(viewModel: viewModel)
                .tapAction {
                    router.navigateTo(.mypageReviewList)
                }
                .tapNickname {
                    router.navigateTo(.mypgaeNickname(viewModel.userInfo.nickname))
                }
                .padding(.init(top: 24,leading: 0,bottom: 30,trailing: 0))
            
            DivideRectangle(height: 12, color: Color.neutral50)
            
            MypageInfoView()
                .padding(.bottom, 20)
            
            HStack {
                MypageButton(title: "로그아웃")
                    .tap {
                        viewModel.send(.logout)
                    }
    
                MypageButton(title: "회원탈퇴")
                    .tap {
                        viewModel.send(.revoke)
                    }
            }
            .padding(.horizontal, 22)
            
            Spacer()
        }
        .ZSnavigationTitle("마이페이지")
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.send(.getUserBasicInfo)
        }
    }
}

enum MypageCenter: String, CaseIterable {
    case customCenter = "고객센터"
    case service = "서비스 이용"
    
    var type: [String] {
        switch self {
        case .customCenter:
            return ["공지사항", "FAQ", "1:1 문의"]
        case .service:
            return ["서비스 이용약관", "개인정보 처리방침", "앱 버전 정보"]
        }
    }
}

#Preview {
    MypageMainView(viewModel: MypageViewModel(mypageUseCase: MypageUsecase(mypageRepoProtocol: MypageRepository(apiService: ApiService()))))
}
