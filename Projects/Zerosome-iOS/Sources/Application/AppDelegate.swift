//
//  AppDelegate.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem
import FirebaseCore
import AdSupport
import AppTrackingTransparency

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        DesignSystemFontFamily.registerAllCustomFonts()
        return true
    }
    
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//        for family in UIFont.familyNames {
//            let sName: String = family as String
//            print("Font family: \(sName)")
//                    
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("Font name: \(name as String)")
//            }
//        }
//        DesignSystemFontFamily.registerAllCustomFonts()
//        return true
//    }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}
