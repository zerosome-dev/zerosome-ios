//
//  CustomPopup.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public enum AlertType {
    case firstButton(title: String, button: String)
    case doubleButton(title: String, LButton: String, RButton: String)
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
                        isShowing = false
                    }
                
                switch type {
                case .firstButton(let title, let button):
                    FirstButtonView(title: title,
                                    button: button,
                                    leftAction: leftAction)
                        .padding(.horizontal, 37)
                        
                case .doubleButton(let title, let LButton, let RButton):
                    DoubleButtonView(title: title,
                                     LButton: LButton,
                                     RButton: RButton,
                                     leftAction: leftAction,
                                     rightAction: rightAction)
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
