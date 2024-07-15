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
    @ObservedObject var viewModel: CategoryFilteredViewModel
    var body: some View {
        VStack {
            Text("제로태그")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical ,24)
            
            ScrollView {
                ChipsContainerView(array: $viewModel.zeroTag, types: ZeroDrinkSampleData.data)
            }
            .scrollIndicators(.hidden)
            Spacer()
            BottomSheetButton(enable: !viewModel.zeroTag.isEmpty)
                .tapResetAction {
                    viewModel.zeroTag = []
                }
                .tapApplyAction {
                    viewModel.sheetToggle = nil
                }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ZeroTagBottomSheet(viewModel: CategoryFilteredViewModel())
}

