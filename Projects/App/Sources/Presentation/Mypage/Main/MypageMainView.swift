//
//  MypageMainView.swift
//  App
//
//  Created by 박서연 on 2024/07/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MypageMainView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ScrollView {
            UserInfoView()
                .tapAction {
                    router.navigateTo(.mypageReviewList)
                }
                .tapNickname {
                    router.navigateTo(.mypgaeNickname)
                }
                .padding(.init(top: 24,leading: 0,bottom: 30,trailing: 0))
            
            DivideRectangle(height: 12, color: Color.neutral50)
            
            MypageInfoView()
                .padding(.bottom, 20)
            
            HStack {
                MypageButton(title: "로그아웃")
                    .tap {
                        print("로그아웃")
                    }
    
                MypageButton(title: "회원탈퇴")
                    .tap {
                        print("회원 탈퇴")
                    }
            }
            .padding(.horizontal, 22)
            
            Spacer()
        }
        .ZSnavigationTitle("마이페이지")
        .scrollIndicators(.hidden)
    }
}


struct MypageInfoView: View {
    var body: some View {
        VStack {
            ForEach(MypageCenter.allCases, id: \.self) { center in
                Text(center.rawValue)
                    .applyFont(font: .body3)
                    .foregroundStyle(Color.neutral300)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                ForEach(center.type, id: \.self) { type in
                    HStack {
                        Text(type)
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        if type == MypageCenter.service.type.last! {
                            Text("앱 버전1.201.23")
                                .applyFont(font: .body2)
                                .foregroundStyle(Color.neutral500)
                        } else {
                            ZerosomeAsset.ic_arrow_after
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        
                    }
                    .onTapGesture {
                        print("case 별로 이동 처리 추가 예정")
                    }
                }
                .padding(.bottom, 10)
                DivideRectangle(height: 1, color: Color.neutral100)
            }
        }
        .padding(.horizontal, 22)
    }
}

enum MypageCenter: String, CaseIterable {
    case customCenter = "고객센터"
    case service = "서비스 이용"
    
    var type: [String] {
        switch self {
        case .customCenter:
            return ["공지사항", "FAQ", "1:1 문의"]
        case .service:
            return ["설정", "약관 및 정책", "앱 버전 정보"]
        }
    }
}

#Preview {
    MypageMainView()
}
