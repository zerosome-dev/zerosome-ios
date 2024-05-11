//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/01/25.
//
import ProjectDescription

public enum Environment {
    public static let appName = "zerosome"
    public static let targetName = "zerosome"
    public static let targetTestName = "\(targetName)Tests"
    public static let organizationName = "iOS"
    public static let platform = Platform.iOS
}

public extension SourceFilesList {
  static let sources: SourceFilesList = ["Sources/**"]
  static let resources: SourceFilesList = "Resources/**"
  static let tests: SourceFilesList = "Tests/**"
}
