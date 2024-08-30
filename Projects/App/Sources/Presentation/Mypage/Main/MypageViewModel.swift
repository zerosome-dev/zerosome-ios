//
//  MypageViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
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
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("GetUserBasicInfo Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    print("마이페이지 유저 인포 🩵 \(data)")
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
