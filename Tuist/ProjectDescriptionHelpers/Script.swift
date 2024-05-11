//
//  Script.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/01/25.
//

import ProjectDescription

// Swift Lint 설정
public extension TargetScript {
    static let swiftLintPath = Self.pre(path: "Scripts/SwiftLintRunScript.sh", arguments: [], name: "SwiftLint", basedOnDependencyAnalysis: false)
}
