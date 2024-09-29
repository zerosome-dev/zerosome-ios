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
import FirebaseAnalytics

// 계정 상태 명시
enum AuthenticationState {
    case splash
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
    
    @Published var authenticationState: AuthenticationState = .splash
    @Published var loginAlert: Bool = false
    @Published var loginType: Login?
    @Published var marketingAgreement: Bool = false
    @Published var tokenStatus: Bool = true
    @Published var userInfo: MemberBasicInfoResult?
    
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
                    .flatMap { value -> AnyPublisher<TokenResponseResult, NetworkError> in
                        self.userInfo = value
                        self.tokenStatus = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.authenticationState = .signIn
                        }
                        return Empty().eraseToAnyPublisher()
                    }
                    .catch { error -> AnyPublisher<TokenResponseResult, NetworkError> in
                        self.tokenStatus = false
                        return self.accountUseCase.checkRefreshToken().eraseToAnyPublisher()
                    }
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.authenticationState = .initial
                            debugPrint("check token error \(error.localizedDescription)")
                        }
                    } receiveValue: { result in
                        AccountStorage.shared.accessToken = result.accessToken
                        AccountStorage.shared.refreshToken = result.refreshToken
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.authenticationState = .signIn
                        }
                        LogAnalytics.logLogin(method: KeyChain.read(key: "socialType") ?? "")
                    }
                    .store(in: &cancellables)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.authenticationState = .initial
                }
            }
        
        case .kakaoSignIn:
            KeyChain.create(key: "socialType", token: "KAKAO")
            LogAnalytics.logSignUpBegin(method: "Kakao")
            
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
            LogAnalytics.logSignUpBegin(method: "Apple")
            
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
                    debugPrint("🔴🍎🔴 애플 토큰 실패 \(failure.localizedDescription) 🔴🍎🔴")
                }
            }
        }
    }
}

struct LogAnalytics {
    static func logStartApplication() {
        Analytics.logEvent("Start", parameters: nil)
    }
    
    static func logSignUpBegin(method: String) {
        Analytics.logEvent("sign_up_beign", parameters: ["method" : method])
    }
    
    static func logSignUp(method: String) {
        Analytics.setUserProperty(method, forName: "signup_method")
        Analytics.logEvent("sign_up", parameters: ["method" : method])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let currentDateString = dateFormatter.string(from: Date())
        Analytics.setUserProperty(currentDateString, forName: "sign_up")
    }
    
    static func logLogin(method: String) {
        Analytics.logEvent("login", parameters: ["method" : method])
    }
    
    static func logD1Category(category: String) {
        Analytics.logEvent("Search_Category", parameters: ["item_first_category_name" : category])
    }
    
    static func logD2Category(category: String) {
        Analytics.logEvent("Search_Category", parameters: ["item_second_category_name" : category])
    }
    
    static func logProductName(name: String) {
        Analytics.logEvent("View_item", parameters: ["item_name" : name])
    }
    
    static func logProductBrand(brand: String) {
        Analytics.logEvent("View_item", parameters: ["item_brand" : brand])
    }
    
    static func logProductD1Category(d1Category: String) {
        Analytics.logEvent("View_item", parameters: ["item_first_category" : d1Category])
    }
    
    static func logProductD2Category(d2Category: String) {
        Analytics.logEvent("View_item", parameters: ["item_second_category" : d2Category])
    }
    
    static func logOnlineSite(name: String, brand: String, webSite: String) {
        Analytics.logEvent("Click_Website", parameters: ["item_name" : name])
        Analytics.logEvent("Click_Website", parameters: ["item_brand" : brand])
        Analytics.logEvent("Click_Website", parameters: ["Website_name" : webSite])
    }
}
