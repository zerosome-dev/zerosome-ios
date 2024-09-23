//
//  LoginButton.swift
//  App
//
//  Created by 박서연 on 2024/06/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum Login: String, CaseIterable {
    case kakao
    case apple
    
    var image: Image {
        switch self {
        case .kakao:
            return ZerosomeAsset.ic_kakako
        case .apple:
            return ZerosomeAsset.ic_apple
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .kakao:
            return Color.kakao
        case .apple:
            return Color.black
        }
    }
    
    var titleColor: Color {
        switch self {
        case .kakao:
            return Color.neutral800
        case .apple:
            return Color.white
        }
    }
    
    var title: String {
        switch self {
        case .kakao:
            "카카오 ID로 로그인"
        case .apple:
            "Apple ID로 로그인"
        }
    }
    
    var type: String {
        switch self {
        case .kakao:
            "KAKAO"
        case .apple:
            "APPLE"
        }
    }
}

struct LoginButton: View {
    let type: Login
    
    init(type: Login) {
        self.type = type
    }
    
    var body: some View {
        ZSText(type.title, fontType: .subtitle1, color: type.titleColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .leading) {
                type.image
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            }
    }
}


#Preview {
    LoginButton(type: .apple)
}
