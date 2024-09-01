//
//  ButtonView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
    let backgroundColor: Color
    let foregroundColor: Color
    
    public func body(content: Content) -> some View {
        content
            .padding(.vertical, 10.5)
            .frame(maxWidth: .infinity)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

public struct FirstButtonView: View {
    public let title: String
    public let button: String
    public var leftAction: (() -> Void)?
    
    public var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .frame(maxWidth: .infinity)
                .applyFont(font: .heading2)
            
            Text(button)
                .frame(maxWidth: .infinity)
                .modifier(AlertModifier(
                    backgroundColor: Color.primaryFF6972,
                    foregroundColor: Color.white)
                )
                .applyFont(font: .subtitle1)
                .onTapGesture {
                    leftAction?()
                }
        }
        .padding(.init(top: 32, leading: 16, bottom: 16, trailing: 16))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

public extension FirstButtonView {
    func tapButton(leftAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.leftAction = leftAction
        return copy
    }
}

public struct DoubleButtonView: View {
    public let title: String
    public let LButton: String
    public let RButton: String
    public var leftAction: (() -> Void)?
    public var rightAction: (() -> Void)?

    public var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 12) {
                Text(LButton)
                    .frame(maxWidth: .infinity)
                    .modifier(AlertModifier(
                        backgroundColor: Color.neutral100,
                        foregroundColor: Color.neutral500)
                    )
                    .onTapGesture {
                        leftAction?()
                    }
                
                Text(RButton)
                    .frame(maxWidth: .infinity)
                    .modifier(AlertModifier(
                        backgroundColor: Color.primaryFF6972,
                        foregroundColor: Color.white)
                    )
                    .onTapGesture {
                        rightAction?()
                    }
            }
            .applyFont(font: .subtitle1)
        }
        .padding(.init(top: 32, leading: 16, bottom: 16, trailing: 16))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

public extension DoubleButtonView {
    func tapLeft(leftAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.leftAction = leftAction
        return copy
    }
    func tapRight(rightAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.rightAction = rightAction
        return copy
    }
}
