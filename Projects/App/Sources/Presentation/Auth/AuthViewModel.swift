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
                accountUseCase.checkUserToken()
                    .receive(on: DispatchQueue.main)
                    .flatMap { _ -> AnyPublisher<TokenResponseResult, NetworkError> in
                        // Access Token이 유효하면 바로 성공, 갱신할 필요 없음
                        self.tokenStatus = true
                        self.authenticationState = .signIn
                        return Empty().eraseToAnyPublisher() // 아무 작업도 하지 않음
                    }
                    .catch { error -> AnyPublisher<TokenResponseResult, NetworkError> in
                        // Access Token이 유효하지 않다면 Refresh Token을 체크
                        self.tokenStatus = false
                        return self.accountUseCase.checkRefreshToken().eraseToAnyPublisher() // Future -> AnyPublisher 변환
                    }
                    .receive(on: DispatchQueue.main) // 메인 스레드에서 결과를 받음
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            // Refresh Token도 실패 시 다시 로그인
                            self.authenticationState = .initial
                            print("토큰 갱신 실패: \(error.localizedDescription)")
                        }
                    } receiveValue: { result in
                        // 토큰이 갱신되었으면 새로 저장
                        AccountStorage.shared.accessToken = result.accessToken
                        AccountStorage.shared.refreshToken = result.refreshToken
                        self.authenticationState = .signIn
                    }
                    .store(in: &cancellables)
            } else {
                self.authenticationState = .initial
            }
        
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
