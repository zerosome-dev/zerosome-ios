//
//  Ex+View+Navigation.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

public extension View {
    func navigationTitleBackButton(title: String, _ action: @escaping () -> Void) -> some View {
        self.navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text(title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(Color.neutral900)
                            .applyFont(font: .heading2)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    ZerosomeAsset.ic_back_button
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            action()
                        }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 24, height: 24)
                }
            }
    }
    
    func navigationBackButton(_ action: @escaping () -> Void) -> some View {
        self.navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: action, label: {
                        ZerosomeAsset.ic_back_button
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                }
            }
    }
    
    func ZSnavigationTitle(_ text: String) -> some View {
        VStack {
            Text(text)
                .applyFont(font: .heading1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 22, bottom: 10, trailing: 0))
            self
            Spacer()
        }
    }
}
