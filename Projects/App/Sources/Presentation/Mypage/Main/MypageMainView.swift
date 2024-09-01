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
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: MypageViewModel
    @EnvironmentObject var popup: PopupAction
    
    var body: some View {
        ScrollView {
            UserInfoView(viewModel: viewModel)
                .tapAction { router.navigateTo(.mypageReviewList) }
                .tapNickname { router.navigateTo(.mypgaeNickname(viewModel.userInfo.nickname)) }
                .padding(.init(top: 24,leading: 0,bottom: 30,trailing: 0))
            
            DivideRectangle(height: 12, color: Color.neutral50)
            MypageInfoView()
            
            HStack {
                MypageButton(title: "로그아웃")
                    .tap {
                        viewModel.send(.logout)
//                        viewModel.logoutResult = false
                    }
                    .onReceive(viewModel.$logoutResult) { result in
                        accountAction(result: result, type: .failLogout)
                    }
    
                MypageButton(title: "회원탈퇴")
                    .tap {
                        viewModel.send(.revoke)
//                        viewModel.revokeResult = false
                    }
                    .onReceive(viewModel.$revokeResult) { result in                   accountAction(result: result, type: .failRevoke)
                    }
            }
            .padding(.horizontal, 22)
            Spacer()
        }
        .onAppear {
            viewModel.send(.getUserBasicInfo)
        }

        .ZSnavigationTitle("마이페이지")
        .scrollIndicators(.hidden)
        .overlay {
            ProgressView()
                .tint(Color.primaryFF6972)
                .opacity(viewModel.loading ? 1 : 0)
        }
    }
    
    private func accountAction(result: Bool?, type: SinglePopup) {
        DispatchQueue.main.async {
            guard let toggle = result else { return }
            
            if toggle {
                authViewModel.authenticationState = .initial
                debugPrint("success")
            } else {
                debugPrint("fail")
                popup.settingToggle(type: type)
                popup.setToggle(for: type, true)
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
