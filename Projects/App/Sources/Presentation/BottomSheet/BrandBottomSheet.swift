//
//  BrandBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/14.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct BrandBottomSheet: View {
    @ObservedObject var viewModel: CategoryFilteredViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZSText("브랜드", fontType: .heading2, color: .neutral900)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                ChipsContainerView(
                    viewModel: viewModel,
                    tappedChips: $viewModel.tappedBrandChips,
                    types: viewModel.brandList
                )
            }
            .frame(maxHeight: 362)
            .scrollIndicators(.hidden)
            
            Spacer()
            BottomSheetButton(enable: !viewModel.tappedBrandChips.isEmpty)
                .tapResetAction {
                    viewModel.tappedBrandChips = []
                    viewModel.offset = 0
                    viewModel.send(action: .getFilterResult)
                    viewModel.sheetToggle = nil
                }
                .tapApplyAction {
                    viewModel.offset = 0
                    viewModel.send(action: .getFilterResult)
                    viewModel.sheetToggle = nil
                }
        }
        .onAppear {
            viewModel.send(action: .getBrandList)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    BrandBottomSheet(viewModel: CategoryFilteredViewModel(initD2CategoryCode: "CTG001001", initD1CategoryCode: "CTG001", filterUsecase: FilterUsecase(filterRepoProtocol: FilterRepository(apiService: ApiService()))))
}
