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
                ChipsContainerView(viewModel: viewModel, tappedChips: $viewModel.tappedZeroTagChips, types: viewModel.zeroTagList)
            }
            .scrollIndicators(.hidden)
            Spacer()
            BottomSheetButton(enable: !viewModel.tappedZeroTagChips.isEmpty)
                .tapResetAction {
                    viewModel.tappedZeroTagChips = []
                }
                .tapApplyAction {
                    viewModel.sheetToggle = nil
                    viewModel.offset = 0
                    viewModel.send(action: .getFilterResult)
                }
        }
        .padding(.horizontal, 24)
    }
}
