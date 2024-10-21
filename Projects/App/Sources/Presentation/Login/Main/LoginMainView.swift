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
                                        viewModel.loginType = .apple
                                        viewModel.send(action: .appleSignIn)
                                    case .kakao:
                                        viewModel.loginType = .kakao
                                        viewModel.send(action: .kakaoSignIn)
                                    }
                                }
                            }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 20, trailing: 24))
                
                VStack(spacing: 2) {
                    ZSText("일단 둘러볼게요", fontType: .body2, color: .white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    DivideRectangle(height: 1, color: .white)
                        .frame(width: 88)
                }
                .onTapGesture {
                    viewModel.authenticationState = .guest
                }
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

