//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/10/29.
//

import ProjectDescription

/*
 static let KingFisher = TargetDependency.external(name: "Kingfisher")
 static let Alamofire = TargetDependency.external(name: "Alamofire")
 static let Kakao = TargetDependency.external(name: "KakaoSDK")
 static let Lottie = TargetDependency.external(name: "Lottie")
 static let AutoHeight = TargetDependency.external(name: "AutoHeightEditor")
 static let GoogleUtilities = TargetDependency.external(name: "GoogleUtilities")
 static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
 static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
 static let FirebaseCore = TargetDependency.external(name: "FirebaseCore")
 */

public enum DependencyInformation: String {
    case App = "App"
    case DesignSystem = "DesignSystem"
    case Domain = "Domain"
    case Data = "Data"
    case DI = "DI"
    case Presentation = "Presentation"
    case Dependencies = "Dependencies"
    case KakaoSDK = "KakaoSDK"
    case KingFisher = "KingFisher"
    case FirebaseAnalytics = "FirebaseAnalytics"
    case Swinject = "Swinject"
}

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App : [.Presentation, .DI, .Data],
    .Domain : [.DI, .Dependencies],
    .Data : [.Domain],
    .Presentation : [.DesignSystem, .Domain],
    .DI : [.Swinject]
]
