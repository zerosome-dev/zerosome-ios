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

struct TermView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = TermViewModel()
    
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
                
                SingleTermView(isChecked: $viewModel.isTermChecked, term: .term)
                SingleTermView(isChecked: $viewModel.isPersonalChecked, term: .personalInfo)
                SingleTermView(isChecked: $viewModel.isMarketingChecked, term: .marketing)
                    .tap { term in
                        // 보기 > 사이트로 이동
                    }
            }
            
            Spacer()
            
            CommonButton(title: "다음", font: .subtitle1)
                .enable(viewModel.isAllChecked)
                .tap {
                    authViewModel.authenticationState = .nickname
                    authViewModel.marketingAgreement = viewModel.isMarketingChecked
                }
        }
        .padding(.horizontal, 22)
        .ZSnavigationBackButton {
            authViewModel.authenticationState = .initial
        }
    }
}

#Preview {
    TermView()
}
