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
    func navigationBackButton(_ action: @escaping () -> Void) -> some View {
        VStack {
            ZerosomeAsset.ic_arrow_back
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.init(top: 10,leading: 18,bottom: 10,trailing: 18))
                .onTapGesture {
                    action()
                }
            
            self
        }
    }
    
    func ZSNavigationBackButtonTitle(_ text: String, _ action: @escaping () -> Void) -> some View {
        VStack {
            Text(text)
                .applyFont(font: .heading1)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(alignment: .topLeading) {
                    ZerosomeAsset.ic_arrow_back
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            action()
                        }
                }
                .padding(.init(top: 10,leading: 18,bottom: 10,trailing: 18))
            
            self
        }
    }
    
    func ZSnavigationTitle(_ text: String) -> some View {
        VStack {
            Text(text)
                .applyFont(font: .heading1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10,leading: 22,bottom: 10,trailing: 22))
            self
        }
    }
}


