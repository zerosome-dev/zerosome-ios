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
    
    @Published var authenticationState: AuthenticationState = .initial
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
            Task {
                let result = await socialUseCase.kakaoLogin()
                switch result {
                case .success(let token):
                    debugPrint("🟡 카카오에서 토큰 값 가져오기 성공 \(token) 🟡")
                    let kakaoSignIn = await accountUseCase.signIn(token: token, socialType: "KAKAO")
                    
                    switch kakaoSignIn {
                    case .success(let success):
                        
                        guard let isMember = success.isMember else {
                            self.authenticationState = .term
                            return
                        }
                        
                        debugPrint("🟡 \(isMember) 이미 회원가입 한 유저임, 로그인 성공! 🟡")
                        self.authenticationState = .signIn
                        
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
            Task {
                let result = await socialUseCase.appleLogin()
                
                switch result {
                case .success(let success):
                    guard let _ = success.isMember else {
                        debugPrint("🍏🍎 새로운 유저의 애플 로그인 회원가입 진행 > term으로 이동 🍏🍎")
                        self.authenticationState = .term
                        return
                    }
                    
                    debugPrint("🍏🍏 유저의 애플 로그인 성공 > signIn으로 이동 🍏🍏")
                    if let userToken = success.token { // 이미 회원가입을 한 유저였을 때
                        AccountStorage.shared.accessToken = userToken.accessToken
                        AccountStorage.shared.refreshToken = userToken.refreshToken
                        self.authenticationState = .signIn
                    }
                    
                case .failure(let failure):
                    debugPrint("🍎🍎 애플 로그인 시도 함수 완전 실패\(failure.localizedDescription) 🍎🍎")
                    self.authenticationState = .initial
                }
            }
        }
    }
}
