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
    }
    
    private let accountUseCase: AccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        accountUseCase: AccountUseCase,
        initialNickname: String // 외부에서 초기값 전달
    ) {
        self.accountUseCase = accountUseCase
        self.nickname = initialNickname // 전달받은 값으로 nickname 설정
    }
    
    @Published var nickname: String {
        didSet {
            checkNickname()
        }
    }
    
    @Published var isValid: Bool = false
    @Published var nicknameErrorMessage: NicknameErrorCase = .none

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
