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
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
            
            HStack {
                MypageButton(title: "로그아웃")
                    .tap {
                        viewModel.send(.logout)
                        viewModel.logoutResult = false
                    }
                    .onReceive(viewModel.$logoutResult) { result in
                        accountAction(result: result)
                    }
    
                MypageButton(title: "회원탈퇴")
                    .tap {
                        viewModel.send(.revoke)
                        viewModel.logoutResult = false
                    }
                    .onReceive(viewModel.$revokeResult) { result in
                        accountAction(result: result)
                    }
            }
            .padding(.horizontal, 22)
            
            Spacer()
        }
        .onAppear {
//            viewModel.send(.getUserBasicInfo)
        }

        .ZSnavigationTitle("마이페이지")
        .scrollIndicators(.hidden)
        .overlay {
            ProgressView()
                .tint(Color.primaryFF6972)
                .opacity(viewModel.loading ? 1 : 0)
        }
        .ZAlert(
            isShowing: $viewModel.loginPopup, type: .firstButton(
                title: "로그아웃에 실패했어요.",
                button: "다시 시도해주세요"
            ), leftAction:  {
                viewModel.loginPopup = false
            }
        )
        .ZAlert(
            isShowing: $viewModel.revokePopup, type: .firstButton(
                title: "회원탈퇴에 실패했어요.",
                button: "다시 시도해주세요"
            ), leftAction:  {
                viewModel.revokePopup = false
            }
        )
    }
    
    private func accountAction(result: Bool?) {
        DispatchQueue.main.async {
            guard let toggle = result else { return }
            if toggle {
                authViewModel.authenticationState = .initial
                debugPrint("revoke success")
            } else {
                viewModel.revokePopup = true
                debugPrint("revoke fail")
            }
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
