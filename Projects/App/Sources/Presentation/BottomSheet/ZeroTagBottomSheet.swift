//
//  ZeroTagBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ZeroTagBottomSheet: View {
    @ObservedObject var viewModel = CategoryViewModel()
    var body: some View {
        VStack {
            Text("제로태그")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
            ChipsContainerView(types: ZeroDrinkSampleData.data)
            
            Spacer()
            BottomSheetButton()
                .tapResetAction {
                    viewModel.zeroTag = []
                }
                .tapApplyAction {
                    print("적용")
                }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ZeroTagBottomSheet()
}


struct BottomSheetButton: View {
    var resetAction: (() -> Void)?
    var applyAction: (() -> Void)?
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
            
            CommonButton(title: "적용", font: .subtitle1)
                .frame(maxWidth: width * 2)
                .onTapGesture {
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
