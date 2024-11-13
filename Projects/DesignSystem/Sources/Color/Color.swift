//
//  Color.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    public static let primaryFF6972 = Color(asset: DesignSystemAsset.Assets.primary)
    
    public static let neutral900 = Color(asset: DesignSystemAsset.Assets.neutral900)
    public static let neutral800 = Color(asset: DesignSystemAsset.Assets.neutral800)
    public static let neutral700 = Color(asset: DesignSystemAsset.Assets.neutral700)
    public static let neutral600 = Color(asset: DesignSystemAsset.Assets.neutral600)
    public static let neutral500 = Color(asset: DesignSystemAsset.Assets.neutral500)
    public static let neutral400 = Color(asset: DesignSystemAsset.Assets.neutral400)
    public static let neutral300 = Color(asset: DesignSystemAsset.Assets.neutral300)
    public static let neutral200 = Color(asset: DesignSystemAsset.Assets.neutral200)
    public static let neutral100 = Color(asset: DesignSystemAsset.Assets.neutral100)
    public static let neutral50 = Color(asset: DesignSystemAsset.Assets.neutral50)
    
    public static let positive = Color(asset: DesignSystemAsset.Assets.positive)
    public static let caution = Color(asset: DesignSystemAsset.Assets.caution)
    public static let negative = Color(asset: DesignSystemAsset.Assets.negative)
    public static let information = Color(asset: DesignSystemAsset.Assets.information)
    
    public static let kakao = Color(asset: DesignSystemAsset.Assets.kakao)
    
    public func toUIColor(color: Color) -> UIColor {
        return UIColor(color)
    }
}

extension UIColor {
    public static let primaryFF6972UI = UIColor(asset: DesignSystemAsset.Assets.primary)!//UIColor(asset: DesignSystemAsset.Assets.primary)
    
    public static let neutral900UI = UIColor(asset: DesignSystemAsset.Assets.neutral900)!
    public static let neutral800UI = UIColor(asset: DesignSystemAsset.Assets.neutral800)!
    public static let neutral700UI = UIColor(asset: DesignSystemAsset.Assets.neutral700)!
    public static let neutral600UI = UIColor(asset: DesignSystemAsset.Assets.neutral600)!
    public static let neutral500UI = UIColor(asset: DesignSystemAsset.Assets.neutral500)!
    public static let neutral400UI = UIColor(asset: DesignSystemAsset.Assets.neutral400)!
    public static let neutral300UI = UIColor(asset: DesignSystemAsset.Assets.neutral300)!
    public static let neutral200UI = UIColor(asset: DesignSystemAsset.Assets.neutral200)!
    public static let neutral100UI = UIColor(asset: DesignSystemAsset.Assets.neutral100)!
    public static let neutral50UI = UIColor(asset: DesignSystemAsset.Assets.neutral50)!
    
    public static let positiveUI = Color(asset: DesignSystemAsset.Assets.positive)
    public static let cautionUI = Color(asset: DesignSystemAsset.Assets.caution)
    public static let negativeUI = Color(asset: DesignSystemAsset.Assets.negative)
    public static let informationUI = Color(asset: DesignSystemAsset.Assets.information)
    
    public static let kakaoUI = Color(asset: DesignSystemAsset.Assets.kakao)
}
