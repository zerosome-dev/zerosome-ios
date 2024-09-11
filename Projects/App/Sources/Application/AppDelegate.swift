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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:           // 허용됨
                        print("Authorized")
                        print("IDFA = \(ASIdentifierManager.shared().advertisingIdentifier)")
                    case .denied:               // 거부됨
                        print("Denied")
                    case .notDetermined:        // 결정되지 않음
                        print("Not Determined")
                    case .restricted:           // 제한됨
                        print("Restricted")
                    @unknown default:           // 알려지지 않음
                        print("Unknow")
                    }
                }
            }
        }
        
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
