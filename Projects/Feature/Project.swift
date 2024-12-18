//
//  Project.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

// MARK: - Feature
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let featureTarget = Target.makeTarget(
    name: "Feature",
    platform: .iOS,
    product: .framework,
    organizationName: "ios",
    deploymentTarget: .iOS(targetVersion: "16.0",
                           devices: [.iphone],
                           supportsMacDesignedForIOS: false),
    dependencies: [],
    infoPlistPath: "Support/Info.plist",
    //    scripts: [.swiftLintPath], // -> lint 적용o
    scripts: [], // -> lint 적용x
    isResources: true,
    hasTest: true)

let featureProject = Project.makeProject(
    name: "Feature",
    targets: featureTarget,
    isXconfigSet: true)

