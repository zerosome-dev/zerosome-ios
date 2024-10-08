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
    
    func ZSnavigationBackButton(_ action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ZerosomeAsset.ic_arrow_back
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.init(top: 10,leading: 18,bottom: 10,trailing: 18))
                    .onTapGesture {
                        action()
                    }
                Spacer()
            }
            
            self.navigationBarBackButtonHidden()
        }
    }
    
    func ZSNavigationBackButtonTitle(_ text: String, _ action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Text(text)
                .applyFont(font: .heading2)
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
            
            self.navigationBarBackButtonHidden()
        }
    }
    
    func ZSNavigationDoubleButton(_ text: String, _ leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Text(text)
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(alignment: .topLeading) {
                    ZerosomeAsset.ic_arrow_back
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            leftAction()
                        }
                }
                .overlay(alignment: .topTrailing) {
                    ZerosomeAsset.ic_info_black
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            rightAction()
                        }
                }
                .padding(.init(top: 10,leading: 18,bottom: 10,trailing: 18))
            
            self.navigationBarBackButtonHidden()
        }

    }
    
    func ZSnavigationTitle(_ text: String) -> some View {
        VStack(spacing: 0) {
            Text(text)
                .applyFont(font: .heading1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10,leading: 22,bottom: 10,trailing: 22))
            self.navigationBarBackButtonHidden()
        }
    }
    
    func ZSmainNaviTitle(_ text: String) -> some View {
        VStack(spacing: 0) {
            Text(text)
                .applyFont(font: .jalnan)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10,leading: 22,bottom: 10,trailing: 22))
                .foregroundStyle(Color.primaryFF6972)
            self.navigationBarBackButtonHidden()
        }
    }
    
    func ZSnavigationImage(_ image: Image) -> some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .frame(width: 117, height: 28)
                .padding(.init(top: 10,leading: 22,bottom: 10,trailing: 22))
            self.navigationBarBackButtonHidden()
        }
    }
}


