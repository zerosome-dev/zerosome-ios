//
//  Dependencies.swift
//  Config
//
//  Created by 박서연 on 2024/05/11.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(
                url: "https://github.com/onevcat/Kingfisher.git",
                requirement: .upToNextMajor(from: "7.10.2")),
            .remote(url: "https://github.com/Alamofire/Alamofire.git",
                    requirement:.upToNextMajor(from: "5.8.1")),
            .remote(url: "https://github.com/kakao/kakao-ios-sdk",
                    requirement: .upToNextMajor(from: "2.0.0")),
            .remote(url: "https://github.com/airbnb/lottie-ios",
                    requirement: .upToNextMajor(from: "4.4.3")),
            .remote(url: "https://github.com/wontaeyoung/AutoHeightEditor",
                    requirement: .upToNextMajor(from: "1.0.0"))
        ]
    ),

    platforms: [.iOS]
)


