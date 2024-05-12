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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    for family in UIFont.familyNames.sorted() {
                        let names = UIFont.fontNames(forFamilyName: family)
                        print("Family: \(family) Font names: \(names)")
                    }
                }
        }
    }
}
