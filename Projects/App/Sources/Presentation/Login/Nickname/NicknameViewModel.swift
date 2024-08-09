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
    @Published var nickname: String = "" {
        didSet {
            checkNickname()
        }
    }
    
    private let authViewModel: AuthViewModel
    private let accountUseCase: AccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
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
            print("카카오 회원가입 진행")
            authViewModel.authenticationState = .signIn

        case .signUpApple:
            print("애플 회원가입 진행")
            authViewModel.authenticationState = .signIn

        case .checkNickname:
            Task {
                let result = await accountUseCase.checkNickname(nickname: nickname)
                
                switch result {
                case .success(let success):
                    self.isValid = success
                case .failure(let failure):
                    print("nickname 중복 또는 실패 \(failure.localizedDescription)")
                    self.isValid = false
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
                self?.send(action: .checkNickname)
            }
            .store(in: &cancellables)
    }
    
    func validationText() -> String {
        if nickname.isEmpty {
            return ""
        } else {
            if isValid {
                return "사용 가능한 닉네임입니다."
            } else {
                return "이미 사용중인 닉네임입니다."
            }
        }
    }
}
