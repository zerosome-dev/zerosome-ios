//
//  MypageMain.swift
//  App
//
//  Created by 박서연 on 2024/07/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MypageMain: View {
    var body: some View {
        VStack {
            UserInfoView()
                .padding(.bottom, 30)
            DivideRectangle(height: 12, color: Color.neutral50)
            
            MypageInfoView()
                .padding(.bottom, 20)
            
            HStack {
                ForEach(UserAction.allCases, id: \.self) { type in
                    MypageButton(title: type.rawValue)
                }
            }
            .padding(.horizontal, 22)
            
            Spacer()
            
        }
        .ZSnavigationTitle("마이페이지")
    }
}

enum UserAction: String, CaseIterable {
    case logout = "로그아웃"
    case remove = "회원탈퇴"
}

struct MypageButton: View {
    let title: String
    var action: (() -> Void)?
    
    var body: some View {
        Text(title)
            .applyFont(font: .body3)
            .foregroundStyle(Color.neutral400)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.neutral100)
            }
            .onTapGesture {
                action?()
            }
    }
}

struct UserInfoView: View {
    let reviewCount: Int = 0
    var body: some View {
        VStack {
            HStack {
                Text("닉네임닉네임닉네임닉네임")
                    .applyFont(font: .subtitle1)
              
                Spacer()
                Text("닉네임 변경")
                    .applyFont(font: .body3)
                    .foregroundStyle(Color.neutral600)
                    .padding(.init(top: 6,leading: 10, bottom: 6, trailing: 10))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.bottom, 30)
            
            Text(reviewCount == 0 ? "아직 작성한 리뷰가 없어요" : "작성한 리뷰 (reviewCount)")
                .applyFont(font: .subtitle2)
                .foregroundStyle(Color.neutral800)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.negative.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal, 22)
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
    MypageMain()
}
