//
//  Font.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/05/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public enum ZSFont {
    case heading1
    case heading2
    case subtitle1
    case subtitle2
    case body1
    case body2
    case body3
    case body4
    case label1
    case label2
    case caption
}

extension ZSFont {
    
    public var name: String {
        switch self {
        case .heading1:
            return DesignSystemFontFamily.Pretendard.bold.name
        case .heading2:
            return DesignSystemFontFamily.Pretendard.bold.name
        case .subtitle1:
            return DesignSystemFontFamily.Pretendard.semiBold.name
        case .subtitle2:
            return DesignSystemFontFamily.Pretendard.semiBold.name
        case .body1:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .body2:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .body3:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .body4:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .label1:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .label2:
            return DesignSystemFontFamily.Pretendard.medium.name
        case .caption:
            return DesignSystemFontFamily.Pretendard.medium.name
        }
    }
    
    public var size: CGFloat {
        switch self {
        case .heading1:
            return 20
        case .heading2:
            return 18
        case .subtitle1:
            return 15
        case .subtitle2:
            return 14
        case .body1:
            return 15
        case .body2:
            return 14
        case .body3:
            return 13
        case .body4:
            return 12
        case .label1:
            return 13
        case .label2:
            return 11
        case .caption:
            return 13
        }
    }
    
    public var lineHeight: CGFloat {
        switch self {
        case .heading1:
            return CGFloat(ZSFont.heading1.size * 0.135)
        case .heading2:
            return CGFloat(ZSFont.heading2.size * 0.135)
        case .subtitle1:
            return CGFloat(ZSFont.subtitle1.size * 0.140)
        case .subtitle2:
            return CGFloat(ZSFont.subtitle2.size * 0.140)
        case .body1:
            return CGFloat(ZSFont.body1.size * 0.140)
        case .body2:
            return CGFloat(ZSFont.body2.size * 0.140)
        case .body3:
            return CGFloat(ZSFont.body2.size * 0.140)
        case .body4:
            return CGFloat(ZSFont.body2.size * 0.140)
        case .label1:
            return CGFloat(ZSFont.label1.size * 0.140)
        case .label2:
            return CGFloat(ZSFont.label2.size * 0.140)
        case .caption:
            return CGFloat(ZSFont.caption.size * 0.140)
        }
    }
    
    public var lineSpacing: CGFloat {
        switch self {
        case .heading1:
            return -1
        case .heading2:
            return -1
        case .subtitle1:
            return 0
        case .subtitle2:
            return 0
        case .body1:
            return 0
        case .body2:
            return 0
        case .body3:
            return 0
        case .body4:
            return 0
        case .label1:
            return 0
        case .label2:
            return 0
        case .caption:
            return 0
        }
    }
}

public struct FontModifier: ViewModifier {
    let font: ZSFont

    init(font: ZSFont) {
        self.font = font
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(font.name, size: font.size))
            .lineSpacing(font.lineSpacing)
            .padding(.vertical, font.lineHeight)
    }
}

extension View {
    public func applyFont(font: ZSFont) -> some View {
        modifier(FontModifier(font: font))
    }
}

// MARK: - 구조체 단위
public struct YText: View {
    let title: String
    let fontType: ZSFont

    public init(_ title: String, fontType: ZSFont) {
        self.title = title
        self.fontType = fontType
    }

    public var body: some View {
        Text(title)
            .font(.custom(fontType.name, size: fontType.size))
            .padding(.vertical, fontType.lineHeight)
            .lineSpacing(fontType.lineSpacing)
            .applyFont(font: fontType == .heading1 ? .heading1 : .heading2)
    }
}
