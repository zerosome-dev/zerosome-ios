//
//  BottomSheetButton.swift
//  App
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct BottomSheetButton: View {
    var resetAction: (() -> Void)?
    var applyAction: (() -> Void)?
    var enable: Bool
    
    init(enable: Bool) {
        self.enable = enable
    }
    
    var body: some View {
        let width = UIScreen.main.bounds.width / 3
        
        HStack(spacing: 12) {
            Text("초기화")
                .applyFont(font: .subtitle1)
                .frame(height: 52)
                .frame(maxWidth: width)
                .background(Color.neutral100)
                .foregroundStyle(Color.neutral300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    resetAction?()
                }
            
//            CommonButton(title: "적용", font: .subtitle1)
//                .enable(enable)
//                .tap {
//                    applyAction?()
//                    print("적용버튼탐")
//                }
//                .frame(maxWidth: width * 2)
            Text("적용")
                .applyFont(font: .subtitle1)
                .foregroundStyle(enable ? Color.white : Color.neutral300)
                .frame(height: 52)
                .frame(maxWidth: width * 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(enable ? Color.primaryFF6972 : Color.neutral100)
                )
                .onTapGesture {
                    if !enable { return }
                    print("?????")
                    applyAction?()
                }
        }
    }
}

extension BottomSheetButton {
    func tapApplyAction (action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.applyAction = action
        return copy
    }
    
    func tapResetAction (action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.resetAction = action
        return copy
    }
}
