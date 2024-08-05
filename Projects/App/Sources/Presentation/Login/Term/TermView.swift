//
//  TermView.swift
//  App
//
//  Created by 박서연 on 2024/06/19.
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

struct TermView: View {
    @StateObject var viewModel = TermViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isTermChecked: Bool = false
    
    var body: some View {
        VStack(alignment:.leading, spacing: 30) {
            
            VStack(alignment:.leading, spacing: 6) {
                Text("약관에 동의해 주세요")
                    .applyFont(font: .heading1)
                Text("여러분의 개인정보와 서비스 이용 권리\n잘 지켜드릴게요")
                    .applyFont(font: .body2)
                    .foregroundStyle(Color.neutral500)
            }
            
            VStack(alignment: .leading, spacing: 18) {
                HStack(spacing: 12) {
                    (
                        viewModel.isAllChecked
                        ? ZerosomeAsset.ic_check_circle_primary
                        : ZerosomeAsset.ic_check_circle_gray
                    )
                    .onTapGesture {
                        viewModel.toggleAll()
                    }
                    
                    VStack(alignment:.leading, spacing: 2) {
                        Text("모두 동의")
                            .applyFont(font: .heading1)
                        Text("서비스 이용을 위해 아래 약관에 모두 동의합니다.")
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral500)
                    }
                }
                
                DivideRectangle(height: 1, color: Color.neutral100)
                    .padding(.bottom, 3)
                
                SingleTermView(
                    isChecked: $viewModel.isTermChecked,
                    term: .term) { term in
                    print("🎉 이용약관 check")
                }
                
                SingleTermView(
                    isChecked: $viewModel.isPersonalChecked,
                    term: .personalInfo) { term in
                    print("🎉 개인정보 check")
                }
                
                SingleTermView(
                    isChecked: $viewModel.isMarketingChecked,
                    term: .marketing) { term in
                    print("🎉 마케팅 check")
                }
            }
            
            Spacer()
            
            CommonButton(title: "다음", font: .subtitle1)
                .enable(viewModel.isAllChecked)
                .tap {
                    authViewModel.authenticationState = .nickname
                }
        }
        .padding(.horizontal, 22)
        .ZSnavigationBackButton {
            print("back")
        }
    }
}

//#Preview {
//    TermView(authViewModel: AuthViewModel(authUseCase: SignInUseCase(signInRepoProtocol: SignInRepository())))
//}
