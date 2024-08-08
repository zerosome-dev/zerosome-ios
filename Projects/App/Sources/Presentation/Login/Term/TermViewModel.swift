//
//  TermViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import DesignSystem
import SwiftUI

enum Term: CaseIterable{
    case term
    case personalInfo
    case marketing
    
    var title: String {
        switch self {
        case .term:
            return "(필수) 서비스 이용약관 동의"
        case .personalInfo:
            return "(필수) 개인정보 처리방침 동의"
        case .marketing:
            return "(선택) 마케팅 수신 동의"
        }
    }
}

final class TermViewModel: ObservableObject {
    @Published var isAllChecked: Bool = false
    @Published var isTermChecked: Bool = false
    @Published var isPersonalChecked: Bool = false
    @Published var isMarketingChecked: Bool = false
    
    private var cancellables = [AnyCancellable]()
    
    init() {
        Publishers.CombineLatest3($isTermChecked, $isPersonalChecked, $isMarketingChecked)
            .sink { [weak self] term, personalInfo, marketing in
                self?.isAllChecked = term && personalInfo || marketing
            }
            .store(in: &cancellables)
    }
    
    func toggleAll() {
        if isTermChecked && isPersonalChecked && isMarketingChecked {
            isTermChecked = false
            isPersonalChecked = false
            isMarketingChecked = false
        } else {
            isTermChecked = true
            isPersonalChecked = true
            isMarketingChecked = true
        }
    }
}
