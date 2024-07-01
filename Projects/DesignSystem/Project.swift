//
//  Project.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

// MARK: - DesignSystem
import ProjectDescription
import ProjectDescriptionHelpers

let designSystemTarget = Target.makeTarget(
    name: "DesignSystem",
    platform: .iOS,
    product: .framework,
    organizationName: "ios",
    deploymentTarget: .iOS(targetVersion: "16.0",
                           devices: [.iphone],
                           supportsMacDesignedForIOS: false),
    dependencies: [],
    infoPlistPath: "Support/Info.plist",
    scripts: [],
    isResources: true,
    hasTest: false)

let designSystemProject = Project.makeProject(
    name: "DesignSystem",
    targets: designSystemTarget,
    isXconfigSet: false)

