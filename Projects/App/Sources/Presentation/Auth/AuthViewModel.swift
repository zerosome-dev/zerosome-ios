//
//  AuthViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Kingfisher
import DesignSystem
import Combine

// 계정 상태 명시
enum AuthenticationState {
    case initial
    case signIn
    case nickname
    case term
    case needToToken
}

class AuthViewModel: ObservableObject {
    
    enum Action {
        case kakaoSignIn
        case appleSignIn
        case checkToken
        case getUserBasicInfo
    }
    
    private let accountUseCase: AccountUseCase
    private let socialUseCase: SocialUsecase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var authenticationState: AuthenticationState = .initial
    @Published var loginAlert: Bool = false
    @Published var loginType: Login?
    @Published var marketingAgreement: Bool = false
    @Published var tokenStatus: Bool = true
    
    init (
        accountUseCase: AccountUseCase,
        socialUseCase: SocialUsecase
    ) {
        self.accountUseCase = accountUseCase
        self.socialUseCase = socialUseCase
    }
    
    @MainActor
    func send(action: Action) {
        switch action {
        case .checkToken:
            if let _ = AccountStorage.shared.accessToken {
                // accessToken에 값이 있다면
                accountUseCase.checkUserToken()
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.tokenStatus = false
                            print("\(error.localizedDescription)")
                        }
                    } receiveValue: { result in
                        self.tokenStatus = true
                    }
                    .store(in: &cancellables)
                
                if tokenStatus {
                    self.authenticationState = .signIn
                } else {
                    accountUseCase.checkRefreshToken()
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                //refreshToken까지 실패 > 다시 로그인
                                self.authenticationState = .initial
                            }
                        } receiveValue: { result in
                            AccountStorage.shared.accessToken = result.accessToken
                            AccountStorage.shared.refreshToken = result.refreshToken
                        }
                        .store(in: &cancellables)
                }
            } else {
                self.authenticationState = .initial
            }
            
        case .getUserBasicInfo:
            print("dd")
        case .kakaoSignIn:
            KeyChain.create(key: "socialType", token: "KAKAO")
            
            Task {
                let result = await socialUseCase.kakaoLogin()
                switch result {
                case .success(let token):
                    debugPrint("🟡 카카오에서 토큰 값 가져오기 성공 \(token) 🟡")
                    let kakaoSignIn = await accountUseCase.signIn(token: token, socialType: "KAKAO")
                    
                    switch kakaoSignIn {
                    case .success(let success):
                        if let isMember = success.isMember, let token = success.token {
                            debugPrint("🟡 \(isMember) 로그인 성공 > 회원! 🟡")
                            AccountStorage.shared.accessToken = token.accessToken
                            AccountStorage.shared.refreshToken = token.refreshToken
                            self.authenticationState = .signIn
                            return
                        } else {
                            debugPrint("🟡 로그인 함수만 성공 > 비회원 > 회원가입 진행 🟡")
                            self.authenticationState = .term
                        }
                    case .failure(let failure):
                        debugPrint("🟡🔴 카카오 로그인 완전 실패 \(failure.localizedDescription) 🟡🔴")
                        self.authenticationState = .initial
                    }
                case .failure(let failure):
                    debugPrint("🟡🔴 카카오에서 토큰 값 가져오기 실패 \(failure.localizedDescription) 🟡🔴")
                    self.authenticationState = .initial
                }
            }
            
        case .appleSignIn:
            KeyChain.create(key: "socialType", token: "APPLE")
            Task {
                let result = await socialUseCase.appleLogin()
                
                switch result {
                case .success(let token):
                    let appleSignIn = await accountUseCase.signIn(token: token, socialType: "APPLE")
                    
                    switch appleSignIn {
                    case .success(let success):
                        if let isMember = success.isMember, let token = success.token {
                            debugPrint("🍏 \(isMember) 로그인 성공 > 회원! 🍏")
                            AccountStorage.shared.accessToken = token.accessToken
                            AccountStorage.shared.refreshToken = token.refreshToken
                            self.authenticationState = .signIn
                            return
                        } else {
                            debugPrint("🍏🔴 로그인 함수만 성공 > 비회원 > 회원가입 진행 🍏🔴")
                            self.authenticationState = .term
                        }
                    case .failure(let failure):
                        debugPrint("🔴🍎 apple sign in 함수 실패 \(failure.localizedDescription)🔴🍎")
                    }
                case .failure(let failure):
                    print("🔴🍎🔴 애플 토큰 실패 \(failure.localizedDescription) 🔴🍎🔴")
                }
            }
        }
    }
}
