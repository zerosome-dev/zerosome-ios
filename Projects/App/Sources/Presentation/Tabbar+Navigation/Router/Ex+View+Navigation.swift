//
//  Ex+View+Navigation.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public extension View {
    func navigationBackButton(_ action: @escaping () -> Void) -> some View {
        self.navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: action, label: {
                        // TODO: - 백버튼 이미지 수정

                        Image("arrowBack")
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                }
            }
    }
    
    func navigationTitle(with text: Text) -> some View {
        VStack(spacing: 31) {
            HStack(spacing: 0) {
                text
                    .applyFont(font: .heading1)
                    .frame(height: 47)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 10, leading: 22, bottom: 10, trailing: 0))
                Spacer()
            }
            self
        }
    }
}
