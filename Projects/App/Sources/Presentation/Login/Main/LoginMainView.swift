//
//  LoginView.swift
//  App
//
//  Created by 박서연 on 2024/06/18.
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
        case kakaoSignUp
        case appleSignUp
    }
    
    private let accountUseCase: AccountUseCase
    private let socialUseCase: SocialUsecase
    @Published var authenticationState: AuthenticationState = .initial
    
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
        case .kakaoSignIn:
            Task {
                let result = await socialUseCase.kakaoLogin()
                print("result ㅋㅋ 🐛 \(result)")
                switch result {
                case .success(let token):
                    print("🟡 카카오에서 토큰 값 가져오기 성공 \(token) 🟡")
                    let kakaoSignIn = await accountUseCase.signIn(token: token, socialType: "KAKAO")
                    
                    switch kakaoSignIn {
                    case .success(let success):   
                        guard let isMember = success.isMember else { return }
                        if isMember {
                            print("🟡 이미 회원가입 한 유저임, 로그인 성공! 🟡")
                            self.authenticationState = .signIn
                        } else {
                            print("🟡🔴 새로운 유저 > JWT 회원가입 필요함 > nickname으로 이동 🟡🔴")
                            self.authenticationState = .term
                        }
                        
                    case .failure(let failure):
                        print("🟡🔴 카카오 로그인 완전 실패 \(failure.localizedDescription) 🟡🔴")
                        self.authenticationState = .initial
                    }
                case .failure(let failure):
                    print("🟡🔴 카카오에서 토큰 값 가져오기 실패 \(failure.localizedDescription) 🟡🔴")
                    self.authenticationState = .initial
                }
            }
            
//            Task {
//                let result = await accountUseCase.kakaoLogin()
//                switch result {
//                case .success(let success):
//                    print("🟡🟡 KAKAO LOGIN SUCCESSFUL: \(success) 🟡🟡")
//                    self.authenticationState = .nickname
//                case .failure(let failure):
//                    print("🟡🟡 ERROR OCCURRED: \(failure.localizedDescription) 🟡🟡")
//                }
//            }
            
        case .appleSignIn:
            print("appleLogin")
            
        case .kakaoSignUp:
            print("카카오 사인업")
            
        case .appleSignUp:
            print("애플 사인업")
            
        }
    }
    
    func signInWithKakao() async {
        
    }
    
    func signInWithApple() async {
        
    }
}

struct LoginMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.primaryFF6972
                .ignoresSafeArea()
            
            VStack {
                ZerosomeAsset.splash_logo
                    .frame(width: 150, height: 150)
                Spacer().frame(height: 150)
                
                VStack(spacing: 12) {
                    ForEach(Login.allCases, id:\.self) { type in
                        LoginButton(type: type)
                            .onTapGesture {
                                Task {
                                    switch type {
                                    case .apple:
                                        print("🍎🍎 APPLE LOGIN TAPPED!! 🍎🍎")
                                    case .kakao:
                                        print("🟡🟡 KAKAO LOGIN TAPPED!! 🟡🟡")
                                        authViewModel.send(action: .kakaoSignIn)
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                
                VStack(spacing: 2) {
                    Text("일단 둘러볼게요")
                        .applyFont(font: .body2)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    DivideRectangle(height: 1, color: .white)
                        .frame(width: 88)
                }
            }
        }
    }
}

#Preview {
//    LoginMainView(authViewModel: AuthViewModel(
//        authUseCase: SignInUseCase(
//            signInRepoProtocol: SignInRepository()
//        ))
//    )
    LoginMainView(authViewModel: AuthViewModel(
        accountUseCase: AccountUseCase(
            accountRepoProtocol: AccountRepository(
                apiService: ApiService())
        ),
        socialUseCase: SocialUsecase(
            socialRepoProtocol: SocialRepository(
                apiService: ApiService())
        )
    ))
}
