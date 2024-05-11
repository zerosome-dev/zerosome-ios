//
//  Project.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

// MARK: - APP
import ProjectDescription
import ProjectDescriptionHelpers

let appTarget = Target.makeTarget(
    name: "App",
    platform: .iOS,
    product: .app,
    organizationName: "ios",
    deploymentTarget: .iOS(targetVersion: "16.0",
                           devices: [.iphone],
                           supportsMacDesignedForIOS: false),
    dependencies: [.project(target: "SPM", path: .relativeToRoot("Projects/SPM")),
                   .project(target: "Service", path: .relativeToRoot("Projects/Service")),
                   .project(target: "Feature", path: .relativeToRoot("Projects/Feature")),
                   .project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))],
    infoPlistPath: "Support/Info.plist",
    //    scripts: [.swiftLintPath], // -> lint 적용o
    scripts: [], // -> lint 적용x
    isResources: true,
    hasTest: true)

let appProject = Project.makeProject(
    name: "App",
    targets: appTarget,
    isXconfigSet: true)

