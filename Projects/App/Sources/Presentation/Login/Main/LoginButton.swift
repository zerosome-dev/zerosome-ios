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
        HStack(spacing: 0) {
            type.image
                .frame(width: 24, height: 24)
            
            Text(type.title)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 0))
        .applyFont(font: .subtitle1)
        .foregroundStyle(type.titleColor)
        .background(type.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    LoginButton(type: .apple)
}
