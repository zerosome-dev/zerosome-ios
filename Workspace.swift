//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/05/11.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Zerosome", projects: ["Projects/Zerosome-iOS",
                                                       "Projects/SPM",
                                                       "Projects/DesignSystem",
                                                       "Projects/Service",
                                                       "Projects/Feature",])//, additionalFiles: ["README.md"])


