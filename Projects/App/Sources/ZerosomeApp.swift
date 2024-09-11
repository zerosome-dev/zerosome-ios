//
//  ZerosomeApp.swift
//  App
//
//  Created by 박서연 on 2024/05/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import UIKit
import FirebaseCore

@main
struct ZerosomeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var toast = ToastAction()
    @StateObject var popup = PopupAction()
    
    init() {
        if let kakaoApiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: kakaoApiKey)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let apiService = ApiService()
            let accountRepoProtocol = AccountRepository(apiService: apiService)
            let accountUseCase = AccountUseCase(accountRepoProtocol: accountRepoProtocol)
            
            let socialRepoProtocol = SocialRepository(apiService: apiService)
            let socialUseCase = SocialUsecase(socialRepoProtocol: socialRepoProtocol)
            let authViewModel = AuthViewModel(accountUseCase: accountUseCase, socialUseCase: socialUseCase)
            
            RouterView(apiService: apiService) {
                AuthenticatedView(
                    viewModel: authViewModel,
                    accountUseCase: accountUseCase,
                    socialUseCase: socialUseCase,
                    apiService: apiService
                )
                
            }
            .onAppear {
                authViewModel.send(action: .checkToken)
            }
            .environmentObject(toast)
            .environmentObject(popup)
            .onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    print(AuthController.handleOpenUrl(url: url))
                }
            })
        }
    }
}
