//
//  SPM+TargetDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/01/25.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let KingFisher = TargetDependency.external(name: "Kingfisher")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let Kakao = TargetDependency.external(name: "KakaoSDK")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let AutoHeight = TargetDependency.external(name: "AutoHeightEditor")
    static let Analytics = TargetDependency.external(name: "FirebaseAnalytics")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
    static let GoogleUtilities = TargetDependency.external(name: "GoogleUtilities")
}
