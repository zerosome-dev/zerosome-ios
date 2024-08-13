//
//  NicknameViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

class NicknameViewModel: ObservableObject {
    
    @Published var isValid: Bool = false
    @Published var nicknameErrorMessage: NicknameErrorCase = .none
    @Published var nickname: String = "" {
        didSet {
            checkNickname()
        }
    }
    
    private let authViewModel: AuthViewModel
    private let accountUseCase: AccountUseCase
    private var cancellables = Set<AnyCancellable>()

    enum NicknameErrorCase: String {
        case none = ""
        case duplicated = "이미 사용중인 닉네임입니다."
        case rangeError = "2자 ~ 12자 이내의 닉네임만 사용 가능합니다."
        case success = "사용 가능한 닉네임입니다."
    }
    
    enum Action {
        case signUpKakao
        case signUpApple
        case checkNickname
    }
    
    init(
        authViewModel: AuthViewModel,
        accountUseCase: AccountUseCase
    ) {
        self.authViewModel = authViewModel
        self.accountUseCase = accountUseCase
    }
    
    func send(action: Action) {
        switch action {
        case .signUpKakao:
            Task {
                let result = await accountUseCase.signUp(
                    token: AccountStorage.shared.accessToken ?? "",
                    socialType: "KAKAO",
                    nickname: nickname,
                    marketing: authViewModel.marketingAgreement)
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        debugPrint("🟡🟢 KAKAO 회원가입 성공 \(success)🟡🟢")
                        self?.authViewModel.authenticationState = .signIn
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
                    token: AccountStorage.shared.accessToken ?? "",
                    socialType: "APPLE",
                    nickname: nickname,
                    marketing: authViewModel.marketingAgreement)
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        debugPrint("🍏🍏🍏 APPLE 회원가입 성공 \(success) 🍏🍏🍏")
                        self?.authViewModel.authenticationState = .signIn
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
                    case .failure(let failure):
                        debugPrint("nickname 중복 또는 실패 \(failure.localizedDescription)")
                        self?.isValid = false
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
