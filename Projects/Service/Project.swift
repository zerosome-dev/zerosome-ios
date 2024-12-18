//
//  Project.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

// MARK: - Service
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let serviceTarget = Target.makeTarget(
    name: "Service",
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
    hasTest: true)

let serviceProject = Project.makeProject(
    name: "Service",
    targets: serviceTarget,
    isXconfigSet: true)

