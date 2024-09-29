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
    @EnvironmentObject var popup: PopupAction
    @EnvironmentObject var toast: ToastAction
    @ObservedObject var viewModel: MypageViewModel
    
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
                        popup.settingToggle(type: .revoke)
                        popup.setToggle(for: .revoke, true)
                    }
                    .onReceive(popup.$rightButtonFlag) { result in
                        if result {
                            viewModel.send(.revoke)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                guard let temp = viewModel.revokeResult else { return }
                                if temp {
                                    popup.settingToggle(type: .successRevoke)
                                    popup.setToggle(for: .successRevoke, true)
                                } else {
                                    popup.settingToggle(type: .failRevoke)
                                    popup.setToggle(for: .failRevoke, true)
                                }
                            }
                            popup.rightButtonFlag = false
                        }
                    }
                    .onReceive(popup.$successRevoke) { result in
                        if result {
                            withAnimation(.easeInOut) {
                                authViewModel.authenticationState = .initial
                                AccountStorage.shared.reset()
                            }
                        }
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
}

extension MypageMainView {
    private func accountAction(result: Bool?, type: SinglePopup) {
        DispatchQueue.main.async {
            guard let toggle = result else { return }
            
            if toggle {
                withAnimation(.easeInOut) {
                    authViewModel.authenticationState = .initial
                }
            } else {
                popup.settingToggle(type: type)
                popup.setToggle(for: type, true)
            }
        }
    }
}

enum CustomCenter: String, CaseIterable {
    case notice = "공지사항"
    case inquiry = "1:1 문의"
    
    var url: String {
        switch self {
        case .notice:
            return "https://zerosome.imweb.me/notice"
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
        .environmentObject(PopupAction())
}
