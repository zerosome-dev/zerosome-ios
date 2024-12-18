//
//  Project.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

// MARK: - SPM
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let spmTarget = Target.makeTarget(
    name: "SPM",
    platform: .iOS,
    product: .staticFramework,
    organizationName: "ios",
    deploymentTarget: .iOS(targetVersion: "16.0",
                           devices: [.iphone],
                           supportsMacDesignedForIOS: false),
    dependencies: [.SPM.Alamofire,
                   .SPM.Kakao,
                   .SPM.KingFisher,
                   .SPM.Lottie,
                   .SPM.AutoHeight,
                   .SPM.FirebaseAnalytics],
    infoPlistPath: "Support/Info.plist",
    //    scripts: [.swiftLintPath], // -> lint 적용o
    scripts: [], // -> lint 적용x
    isResources: false,
    hasTest: true)

let spmProject = Project.makeProject(
    name: "SPM",
    targets: spmTarget,
    isXconfigSet: true)
/*
 ,
 .SPM.FirebaseCrashlytics,
 .SPM.Analytics,
 .SPM.GoogleUtilities
 */
