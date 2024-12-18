//
//  MypageViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import SwiftUI
import KakaoSDKTalk

class MypageViewModel: ObservableObject {
    
    enum Action {
        case getUserBasicInfo
        case logout
        case revoke
        case linkKakao
    }
    
    private let mypageUseCase: MypageUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(mypageUseCase: MypageUsecase) {
        self.mypageUseCase = mypageUseCase
    }
    
    @Published var userInfo: MemberBasicInfoResult = .init(nickname: "", reviewCnt: 0)
    @Published var logoutResult: Bool?
    @Published var revokeResult: Bool?
    @Published var loginPopup: Bool = false
    @Published var revokePopup: Bool = false
    @Published var loading: Bool = false
    
    func send(_ action: Action) {
        switch action {
        case .getUserBasicInfo:
            mypageUseCase.getUserBasicInfo()
                .receive(on: DispatchQueue.main)
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
            self.loading = true
            mypageUseCase.logout()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        AccountStorage.shared.clearAllTokens()
                        break
                    case .failure(let failure):
                        self.logoutResult = false
                        debugPrint("Failed to logout...... \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    self.logoutResult = result
                }
                .store(in: &cancellables)
            self.loading = false
            
            
        case .revoke:
            mypageUseCase.revoke()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        self.revokeResult = false
                        debugPrint("Failed to revoke \(failure.localizedDescription)")
                        break
                    }
                } receiveValue: { result in
                    self.revokeResult = result
                }
                .store(in: &cancellables)
            
        case .linkKakao:
            if let kakaoId = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_ID") {
                TalkApi.shared.chatChannel(channelPublicId: "\(kakaoId)") { error in
                    if let error = error {
                        debugPrint("kakao 문의하기 에러 발생 \(error.localizedDescription)")
                        if let email = Bundle.main.object(forInfoDictionaryKey: "REPRESENT_EMAIL"),
                           let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    } else {
                        debugPrint("성공")
                    }
                }
            }
        }
    }
    
}
