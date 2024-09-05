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
    @EnvironmentObject var toast: ToastAction
    
    var body: some View {
        ScrollView {
            UserInfoView(viewModel: viewModel)
                .tapAction { router.navigateTo(.mypageReviewList) }
                .tapNickname { router.navigateTo(.mypgaeNickname(viewModel.userInfo.nickname)) }
                .padding(.init(top: 24,leading: 0,bottom: 30,trailing: 0))
            
            DivideRectangle(height: 12, color: Color.neutral50)
            MypageInfoView(vm: viewModel)
            
            HStack {
                MypageButton(title: "로그아웃")
                    .tap {
                        viewModel.send(.logout)
                    }
                    .onReceive(viewModel.$logoutResult) { result in
                        accountAction(result: result, type: .failLogout)
                    }
    
                MypageButton(title: "회원탈퇴")
                    .tap {
                        viewModel.send(.revoke)
                    }
                    .onReceive(viewModel.$revokeResult) { result in                   
                        accountAction(result: result, type: .failRevoke)
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

enum CustomCenter: String, CaseIterable {
    case notice = "공지사항"
    case faq = "FAQ"
    case inquiry = "1:1 문의"
    
    var url: String {
        switch self {
        case .notice:
            return "naver"
        case .faq:
            return "faq"
        case .inquiry:
            return "inquiry"
        }
    }
}

enum Service: String, CaseIterable {
    case term = "서비스 이용약관"
    case personalInfo = "개인정보 처리방침"
    case appVersion = "앱 버전 정보"
    
    var url: String {
        switch self {
        case .term:
            return "https://zerosome.imweb.me/?mode=policy"
        case .personalInfo:
            return "https://zerosome.imweb.me/19"
        case .appVersion:
            return "https://zerosome.imweb.me/20"
        }
    }
}

#Preview {
    MypageMainView(viewModel: MypageViewModel(mypageUseCase: MypageUsecase(mypageRepoProtocol: MypageRepository(apiService: ApiService()))))
}
