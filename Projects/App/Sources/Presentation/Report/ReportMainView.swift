//
//  ReportMainView.swift
//  App
//
//  Created by 박서연 on 2024/07/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum ReportCase: String, CaseIterable {
    case untruthInfo = "거짓 정보 및 허위사실 유포"
    case swearword = "욕설/인신공격"
    case advertisement = "도배, 홍보/광고 행위"
    case threat = "살인/폭력/성적 위협 발언"
    case plaster = "같은 내용 반복 게시"
    case exposure = "개인정보노출"
    case etc = "기타"
}

struct ReportMainView: View {
    @EnvironmentObject var router: Router
    @State private var content: String = ""
    @State private var report: ReportCase? = nil
    private let placeholder = "신고 사유를 상세하게 작성해주세요."
    
    var body: some View {
        VStack(spacing: 0) {
            ZSText("신고하는 이유가 무엇인가요?", fontType: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 20,leading: 0,bottom: 16,trailing: 0))
            
            ForEach(ReportCase.allCases, id: \.self) { value in
                HStack(spacing: 12) {
                    report == value
                    ? ZerosomeAsset.ic_check_circle_primary
                        .resizable()
                        .frame(width: 24, height: 24)
                    : ZerosomeAsset.ic_check_circle_gray
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    ZSText(value.rawValue, fontType: .body2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 20)
                .onTapGesture { report = value }
            }
            
            if report == ReportCase.etc {
                VStack(spacing: 16) {
                    ZSText("상세하게 작성해주세요.", fontType: .heading2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZSTextEditor(content: $content, placeholder: placeholder, maxCount: 1000)
                }
                .padding(.top, 12)
            }
            
            Spacer()
            CommonButton(title: "신고하기", font: .subtitle1)
                .enable(!content.isEmpty)
                .tap {
                    router.navigateBack()
                }
        }
        .padding(.horizontal, 22)
        .ZSNavigationBackButtonTitle("신고하기") {
            router.navigateBack()
        }
    }
}

#Preview {
    ReportMainView()
}
