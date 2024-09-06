//
//  ChangeNicknameViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine

class ChangeNicknameViewModel: ObservableObject {
    
    enum Action {
        case checkNickname
        case changeNickname
    }
    
    private let accountUseCase: AccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        accountUseCase: AccountUseCase,
        initialNickname: String
    ) {
        self.accountUseCase = accountUseCase
        self.nickname = initialNickname 
    }
    
    @Published var nickname: String {
        didSet {
            checkNickname()
        }
    }
    
    @Published var isValid: Bool = false
    @Published var nicknameErrorMessage: NicknameErrorCase = .none
    @Published var changeNicknameResult: Bool?
    @Published var failureToast: Bool = false
    
    func send(_ action: Action) {
        switch action {
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
            
        case .changeNickname:
            accountUseCase.putNickname(nickname: nickname)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.failureToast = true
                        debugPrint("닉네임 변경 실패 \(error.localizedDescription)")
                    }
                } receiveValue: { result in
                    self.changeNicknameResult = true
                }
                .store(in: &cancellables)
        }
    }
    
    func checkNickname() {
        $nickname
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] nickname in
                let result = self?.checkNicknameValidation(nickname) ?? false
                if result {
                    self?.send(.checkNickname)
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
