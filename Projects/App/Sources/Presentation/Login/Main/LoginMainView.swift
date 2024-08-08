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

struct LoginMainView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.primaryFF6972
                .ignoresSafeArea()
            
            VStack {
                ZerosomeAsset.splash_logo
                    .frame(width: 150, height: 150)
                Spacer().frame(height: 150)
                
                VStack(spacing: 12) {
                    ForEach(Login.allCases, id:\.self) { type in
                        LoginButton(type: type)
                            .onTapGesture {
                                Task {
                                    switch type {
                                    case .apple:
                                        viewModel.send(action: .appleSignIn)
                                    case .kakao:
                                        viewModel.send(action: .kakaoSignIn)
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    LoginMainView()
}

/*
 // ver1 제외
//                VStack(spacing: 2) {
//                    Text("일단 둘러볼게요")
//                        .applyFont(font: .body2)
//                        .foregroundStyle(Color.white)
//                        .frame(maxWidth: .infinity, alignment: .center)
//
//                    DivideRectangle(height: 1, color: .white)
//                        .frame(width: 88)
//                }
 */

