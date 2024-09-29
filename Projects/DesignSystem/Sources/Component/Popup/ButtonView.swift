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

public struct ContentDButton: View {
    public let title: String
    public let LButton: String
    public let RButton: String
    public let leftAction: (() -> ())?
    public let rightAction: (() -> ())?
    public let content: String
    
    public init(title: String,
         LButton: String,
         RButton: String,
         leftAction: (() -> Void)? = nil,
         rightAction: (() -> Void)? = nil,
         content: String
    ) {
        self.title = title
        self.LButton = LButton
        self.RButton = RButton
        self.leftAction = leftAction
        self.rightAction = rightAction
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            ZSText(title, fontType: .heading2)
                .padding(.top, 16)
            
            ZSText(content, fontType: .body2, color: Color.neutral800)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 12) {
                ZSText(LButton, fontType: .subtitle1, color: Color.neutral600)
                    .frame(maxWidth: .infinity)
                    .onTapGesture { leftAction?() }
                    .modifier(AlertModifier(
                        backgroundColor: Color.neutral100,
                        foregroundColor: Color.neutral500)
                    )
                
                ZSText(RButton, fontType: .subtitle1, color: Color.white)
                    .frame(maxWidth: .infinity)
                    .onTapGesture { rightAction?() }
                    .modifier(AlertModifier(
                        backgroundColor: Color.primaryFF6972,
                        foregroundColor: Color.white)
                    )
            }.padding(.top, 16)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

public struct SingleDButton: View {
    public let title: String
    public let LButton: String
    public let content: String
    public let leftAction: (() -> ())?
    
    public init(title: String,
         LButton: String,
         content: String,
         leftAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.LButton = LButton
        self.content = content
        self.leftAction = leftAction
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            ZSText(title, fontType: .heading2)
                .padding(.top, 16)
            
            ZSText(content, fontType: .body2, color: Color.neutral800)
                .multilineTextAlignment(.center)
            
            ZSText(LButton, fontType: .subtitle1, color: Color.white)
                .frame(maxWidth: .infinity)
                .onTapGesture { leftAction?() }
                .modifier(AlertModifier(
                    backgroundColor: Color.primaryFF6972,
                    foregroundColor: Color.white)
                )
                .padding(.top, 16)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
