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

struct FirstButtonView: View {
    let title: String
    let button: String
    var confirmButton: (() -> Void)?
    
    var body: some View {
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
                    confirmButton?()
                }
        }
        .padding(.init(top: 32, leading: 16, bottom: 16, trailing: 16))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct DoubleButtonView: View {
    let title: String
    let LButton: String
    let RButton: String
    var confirmButton: (() -> Void)?
    var cancelButton: (() -> Void)?

    var body: some View {
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
                        cancelButton?()
                    }
                
                Text(RButton)
                    .frame(maxWidth: .infinity)
                    .modifier(AlertModifier(
                        backgroundColor: Color.primaryFF6972,
                        foregroundColor: Color.white)
                    )
                    .onTapGesture {
                        confirmButton?()
                    }
            }
            .applyFont(font: .subtitle1)
        }
        .padding(.init(top: 32, leading: 16, bottom: 16, trailing: 16))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
