//
//  MypageMainView.swift
//  App
//
//  Created by 박서연 on 2024/07/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import DesignSystem
import SwiftUI

class MypageViewModel: ObservableObject {
    
    enum Action {
        case getUserBasicInfo
        case logout
        case revoke
    }
    
    private let mypageUseCase: MypageUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(mypageUseCase: MypageUsecase) {
        self.mypageUseCase = mypageUseCase
    }
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Published var userInfo: MemberBasicInfoResult = .init(nickname: "", rivewCnt: 0)
    @Published var logoutResult: Bool = false
    @Published var revokeResult: Bool = false
    
    func send(_ action: Action) {
        switch action {
        case .getUserBasicInfo:
            mypageUseCase.getUserBasicInfo()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("GetUserBasicInfo Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.userInfo = data
                }
                .store(in: &cancellables)
            
        case .logout:
            print("로그아웃")
            mypageUseCase.logout()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Failed to logout \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    if result {
                        self.logoutResult = true
                        self.authViewModel.authenticationState = .initial
                    } else {
                        self.logoutResult = false
                    }
                }
                .store(in: &cancellables)

            
        case .revoke:
            print("회원탈퇴")
            mypageUseCase.revoke()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Failed to revoke \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    if result {
                        self.revokeResult = true
                        self.authViewModel.authenticationState = .initial
                    } else {
                        self.revokeResult = false
                    }
                }
                .store(in: &cancellables)

        }
    }
    
}

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
