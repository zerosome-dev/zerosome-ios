//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/01/25.
//
import ProjectDescription

public extension Target {
    
    static func makeTarget(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0",
                                                  devices: [.iphone],
                                                  supportsMacDesignedForIOS: false),
        dependencies: [TargetDependency] = [],
        infoPlistPath: String = "",
        scripts: [TargetScript] = [],
        isResources: Bool = false,
        hasTest: Bool = false
    ) -> [Self] {
        
        let isProductApp = product == .app ? true : false
        var setting: Settings?
        var entitlements: Entitlements?
        
        if isProductApp {
            /// entitlements 추가 시 해당 주석 지우고 generate 해주세요.
              entitlements = "\(name).entitlements"
            // 빌드 세팅 (xcconfig 있을경우)
            setting = Settings.settings(base: ["OTHER_LDFLAGS":["-all_load -Objc"]],
                                        configurations: [
                                            .debug(name: "Debug", xcconfig: .relativeToRoot("Projects/Zerosome-iOS/Resources/Config/Secrets.xcconfig")),
                                            .release(name: "Release", xcconfig: .relativeToRoot("Projects/Zerosome-iOS/Resources/Config/Secrets.xcconfig")),
                                        ], defaultSettings: .recommended)
        } else {
            // 빌드 세팅 (기본)
            setting = .settings(base: [:],
                                configurations: [.debug(name: .debug),
                                                 .release(name: .release)],
                                defaultSettings: .recommended)
        }
        
        let sources: SourceFilesList = ["Sources/**"]
        
        var resources: ResourceFileElements? {
            if isResources {
                return ["Resources/**"]
            } else {
                return nil
            }
        }
        
        var infoPlist: InfoPlist {
            if infoPlistPath.isEmpty {
                return .default
            } else {
                return .file(path: "\(infoPlistPath)")
            }
        }
        
        let bundleID: String = "com.\(name).\(organizationName)"
        
        // 메인 타겟
        let mainTarget = Target(name: name,
                                platform: platform,
                                product: product,
                                bundleId: bundleID,
                                deploymentTarget: deploymentTarget,
                                infoPlist: infoPlist,
                                sources: sources,
                                resources: resources,
                                entitlements: entitlements,
                                scripts: scripts,
                                dependencies: dependencies,
                                settings: setting
        )
        
        var targets: [Target] = [mainTarget]
        
        // Test 타겟 생성여부.
        if hasTest {
            let testTarget = Target(name: "\(name)Tests",
                                    platform: platform,
                                    product: .unitTests,
                                    bundleId: "\(bundleID)Tests",
                                    deploymentTarget: deploymentTarget,
                                    infoPlist: .default,
                                    sources: ["Tests/**"],
                                    dependencies: [.target(name: name)]
            )
            targets.append(testTarget)
        }
        
        return targets
    }
}

