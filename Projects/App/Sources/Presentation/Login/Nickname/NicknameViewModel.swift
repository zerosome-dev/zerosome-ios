//
//  NicknameViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseAnalytics

enum NicknameErrorCase: String {
    case none = ""
    case duplicated = "이미 사용중인 닉네임입니다."
    case rangeError = "2자 ~ 12자 이내의 닉네임만 사용 가능합니다."
    case success = "사용 가능한 닉네임입니다."
}

class NicknameViewModel: ObservableObject {
    
    enum Action {
        case signUpKakao
        case signUpApple
        case checkNickname
    }
    
    private let authViewModel: AuthViewModel
    private let accountUseCase: AccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        authViewModel: AuthViewModel,
        accountUseCase: AccountUseCase
    ) {
        self.authViewModel = authViewModel
        self.accountUseCase = accountUseCase
    }
    
    @Published var isValid: Bool = false
    @Published var nicknameErrorMessage: NicknameErrorCase = .none
    @Published var nickname: String = "" {
        didSet {
            checkNickname()
        }
    }
    
    func send(action: Action) {
        switch action {
        case .signUpKakao:
            debugPrint("카카오 회원가입 진행")
            Task {
                let result = await accountUseCase.signUp(
                    token: KeyChain.read(key: StorageKey.kakaoToken) ?? "",
                    socialType: "KAKAO",
                    nickname: nickname,
                    marketing: authViewModel.marketingAgreement)
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        debugPrint("🟡🟢 KAKAO 회원가입 성공 \(success)🟡🟢")
                        self?.authViewModel.authenticationState = .signIn
                        LogAnalytics.logSignUp(method: "Kakao")
                    case .failure(let failure):
                        debugPrint("🟡🔴 KAKAO 회원가입 실패 \(failure.localizedDescription)🟡🔴")
                        self?.authViewModel.authenticationState = .nickname
                    }
                }
                
            }
            
        case .signUpApple:
            debugPrint("애플 회원가입 진행")
            Task {
                let result = await accountUseCase.signUp(
                    token: KeyChain.read(key: StorageKey.appleToken) ?? "",
                    socialType: "APPLE",
                    nickname: nickname,
                    marketing: authViewModel.marketingAgreement)
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        debugPrint("🍏🍏🍏 APPLE 회원가입 성공 \(success) 🍏🍏🍏")
                        self?.authViewModel.authenticationState = .signIn
                        LogAnalytics.logSignUp(method: "Apple")
                    case .failure(let failure):
                        debugPrint("🍎🍎🍎 APPLE 회원가입 실패 \(failure.localizedDescription) 🍎🍎🍎")
                        self?.authViewModel.authenticationState = .nickname
                    }
                }
            }

        case .checkNickname:
            Task {
                let result = await accountUseCase.checkNickname(nickname: nickname)
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        self?.isValid = success
                        if success {
                            self?.nicknameErrorMessage = .success
                        } else {
                            self?.nicknameErrorMessage = .duplicated
                        }
                    case .failure(let failure):
                        debugPrint("nickname 중복 또는 실패 \(failure.localizedDescription)")
                        self?.isValid = false
                        self?.nicknameErrorMessage = .duplicated
                    }
                }
            }
        }
    }
}

extension NicknameViewModel {
    func checkNickname() {
        $nickname
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] nickname in
                let result = self?.checkNicknameValidation(nickname) ?? false
                if result {
                    self?.send(action: .checkNickname)
                } else {
                    self?.isValid = false
                }
            }
            .store(in: &cancellables)
    }
    
    func checkNicknameValidation(_ nickname: String) -> Bool {
        if (nickname.isEmpty) {
            nicknameErrorMessage = .none
            return false
        } 
        
        if (nickname.count >= 2 && nickname.count <= 12) {
            nicknameErrorMessage = .success
            return true
        } else {
            nicknameErrorMessage = .rangeError
            return false
        }
    }
}
