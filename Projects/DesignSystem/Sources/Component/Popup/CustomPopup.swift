//
//  CustomPopup.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public enum AlertType {
    case singleButton(title: String, button: String)
    case doubleButton(title: String, LButton: String, RButton: String)
    case contentSButton(title: String, LButton: String, content: String)
    case contentDButton(title: String, LButton: String, RButton: String, content: String)
}

public struct ZeroAlertViewModifier: ViewModifier {
    @Binding var isShowing: Bool
    public let type: AlertType
    public let leftAction: (() -> Void)?
    public let rightAction: (() -> Void)?
    
    init
    (
        isShowing: Binding<Bool>,
        type: AlertType,
        leftAction: (() -> Void)? = nil,
        rightAction: (() -> Void)? = nil
    ) {
        self._isShowing = isShowing
        self.type = type
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            ZStack {
                Color.black.opacity(0.36)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if case .contentSButton(title: "더 많은 콘텐츠가 기다리고 있어요", LButton: "회원가입/로그인", content: "로그인 후 모든 기능을 이용해 보세요!") = type {
                            return
                        } else {
                            isShowing = false
                        }
                    }
                
                switch type {
                case .singleButton(let title, let button):
                    FirstButtonView(
                        title: title,
                        button: button,
                        leftAction: leftAction
                    )
                    .padding(.horizontal, 37)
                        
                case .doubleButton(let title, let LButton, let RButton):
                    DoubleButtonView(
                        title: title,
                        LButton: LButton,
                        RButton: RButton,
                        leftAction: leftAction,
                        rightAction: rightAction
                    )
                    .padding(.horizontal, 37)
                    
                case .contentDButton(let title, let LButton, let RButton, let content):
                    ContentDButton(
                        title: title,
                        LButton: LButton,
                        RButton: RButton,
                        content: content
                    )
                    .padding(.horizontal, 37)
                    
                case .contentSButton(let title, let LButton, let content):
                    SingleDButton(
                        title: title,
                        LButton: LButton,
                        content: content,
                        leftAction: leftAction
                    )
                    .padding(.horizontal, 37)
                }
            }
            .opacity(isShowing ? 1 : 0)
            .animation(.easeInOut, value: isShowing)
        }
    }
}

public extension View {
    func ZAlert(isShowing: Binding<Bool>,
                type: AlertType,
                leftAction: (() -> Void)? = nil,
                rightAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(ZeroAlertViewModifier(
            isShowing: isShowing,
            type: type,
            leftAction: leftAction,
            rightAction: rightAction)
        )
    }
}
