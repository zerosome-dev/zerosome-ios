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
    case doubleButotn(title: String, LButton: String, RButton: String)
}

public struct ZeroAlertViewModifier: ViewModifier {
    @Binding var isShowing: Bool
    public let type: AlertType
    public let confirmButton: (() -> Void)?
    public let cancelButton: (() -> Void)?
    
    init
    (
        isShowing: Binding<Bool>,
        type: AlertType,
         confirmButton: (() -> Void)? = nil,
         cancelButton: (() -> Void)? = nil
    ) {
        self._isShowing = isShowing
        self.type = type
        self.confirmButton = confirmButton
        self.cancelButton = cancelButton
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            ZStack {
                Color.black.opacity(0.36)
                    .ignoresSafeArea()
                
                switch type {
                case .firstButton(let title, let button):
                    FirstButtonView(title: title,
                                    button: button,
                                    confirmButton: confirmButton)
                        .padding(.horizontal, 37)
                        
                case .doubleButotn(let title, let LButton, let RButton):
                    DoubleButtonView(title: title,
                                     LButton: LButton,
                                     RButton: RButton,
                                     confirmButton: confirmButton,
                                     cancelButton: cancelButton)
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
                confirmButton: (() -> Void)? = nil,
                cancelButton: (() -> Void)? = nil
    ) -> some View {
        self.modifier(ZeroAlertViewModifier(
            isShowing: isShowing,
            type: type,
            confirmButton: confirmButton,
            cancelButton: cancelButton)
        )
    }
}
