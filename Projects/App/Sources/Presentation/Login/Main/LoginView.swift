//
//  LoginView.swift
//  App
//
//  Created by 박서연 on 2024/06/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Kingfisher
import DesignSystem



struct LoginView: View {
    var body: some View {
        ZStack {
            Color.primaryFF6972
                .ignoresSafeArea()
            
            VStack {
                ZerosomeAsset.zero_progress
                    .frame(width: 240, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                
                Spacer().frame(height: 123)
                
                VStack(spacing: 12) {
                    ForEach(Login.allCases, id:\.self) { type in
                        LoginButton(type: type)
                            .onTapGesture {
                                switch type {
                                case .apple:
                                    print("apple Login")
                                case .kakao:
                                    print("kakao Login")
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                
                VStack(spacing: 2) {
                    Text("일단 둘러볼게요")
                        .applyFont(font: .body2)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    DivideRectangle(height: 1, color: .white)
                        .frame(width: 88)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
