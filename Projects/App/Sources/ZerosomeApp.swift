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

@main
struct ZerosomeApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    init() {
        if let kakaoApiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: kakaoApiKey)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RouterView {
//                AuthenticationView()
                TabbarMainView()
            }
            .onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    print(AuthController.handleOpenUrl(url: url))
                }
            })
        }
    }
}
