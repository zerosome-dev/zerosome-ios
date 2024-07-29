//
//  CategoryBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CategoryBottomSheet: View {
    
    @ObservedObject var viewModel: CategoryFilteredViewModel
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
    
    var body: some View {
        VStack {
            Text("생수/음료")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(ZeroDrinkSampleData.drinkType, id: \.self) { type in
                    VStack(spacing: 6) {
                        Rectangle()
                            .fill(Color.neutral50)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                if viewModel.category == type {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryFF6972)
                                }
                            }
                        Text(type)
                            .foregroundStyle(Color.neutral900)
                            .applyFont(font: .body2)
                    }
                    .onTapGesture {
                        type == viewModel.category 
                            ? (viewModel.category = "")
                            : (viewModel.category = type)
                    }
                }
            }
            
            Spacer()
            BottomSheetButton(enable: ((viewModel.category?.isEmpty) != nil))
                .tapApplyAction {
                    viewModel.sheetToggle = nil
                }
                .tapResetAction {
                    viewModel.category = ""
                }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    CategoryBottomSheet(viewModel: CategoryFilteredViewModel())
}
