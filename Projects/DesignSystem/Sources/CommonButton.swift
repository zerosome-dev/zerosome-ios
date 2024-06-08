//
//  CommonButton.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CommonButton: View {
    public var title: String
//    public var leadingImage: Image?
    public var isEnable: Bool = true
    public var height: CGFloat = 52
    public var action: (() -> Void)?
    public var font: ZSFont
    
    public init(title: String, font: ZSFont) {
        self.title = title
        self.font = font
    }
    
    public var body: some View {
        Text(title)
            .applyFont(font: font)
            .foregroundStyle(isEnable ? Color.white : Color.neutral300)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(isEnable ? Color.primaryFF6972 : Color.neutral100)
            )
            .onTapGesture {
                action?()
            }
    }
}

extension CommonButton {
    func enable(_ isEnable: Bool) -> Self {
        var copy = self
        copy.isEnable = isEnable
        return copy
    }
    
    func height(_ height: CGFloat) -> Self {
        var copy = self
        copy.height = height
        return copy
    }
    
    func tap(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

