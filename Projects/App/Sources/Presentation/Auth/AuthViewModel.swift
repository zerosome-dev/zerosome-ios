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
    }
    
    private let accountUseCase: AccountUseCase
    private let socialUseCase: SocialUsecase
    
    @Published var authenticationState: AuthenticationState = .signIn 
    @Published var loginAlert: Bool = false
    @Published var loginType: Login?
    @Published var marketingAgreement: Bool = false
    
    @EnvironmentObject var router: Router
    
    init (
        accountUseCase: AccountUseCase,
        socialUseCase: SocialUsecase
    ) {
        self.accountUseCase = accountUseCase
        self.socialUseCase = socialUseCase
    }
    
    func send(action: Action) {
        switch action {
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
