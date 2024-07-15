//
//  BrandBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/14.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct BrandBottomSheet: View {
    @ObservedObject var viewModel: CategoryFilteredViewModel
    
    var body: some View {
        VStack {
            Text("브랜드")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical ,24)
            
            ScrollView {
                ChipsContainerView(array: $viewModel.brand, types: ZeroDrinkSampleData.data)
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            BottomSheetButton(enable: !viewModel.brand.isEmpty)
                .tapApplyAction {
                    viewModel.sheetToggle = nil
                }
                .tapResetAction {
                    viewModel.brand = []
                }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    BrandBottomSheet(viewModel: CategoryFilteredViewModel())
}
