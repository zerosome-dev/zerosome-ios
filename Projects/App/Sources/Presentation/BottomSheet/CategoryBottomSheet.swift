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
            Text(viewModel.navigationTitle)
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.d2CategoryList, id: \.id) { type in
                    VStack(spacing: 6) {
                        Rectangle()
                            .fill(Color.neutral50)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                if let tappedChips = viewModel.tappedD2CategoryChips, tappedChips.name == type.name {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryFF6972)
                                }
                            }
                        ZSText(type.name, fontType: .body2)
                            .lineLimit(1)
                    }
                    .onTapGesture {
                        let tapped = TappedChips(name: type.name, code: type.code)
                        viewModel.tappedD2CategoryChips = tapped
                    }
                }
            }
            
            Spacer()
            BottomSheetButton(enable: viewModel.tappedD2CategoryChips != nil)
                .tapApplyAction {
                    guard let code = viewModel.tappedD2CategoryChips else { return }
                    
                    viewModel.offset = 0
                    viewModel.d2CategoryCode = code.id
                    viewModel.send(action: .getFilterResult)
                    
                    viewModel.sheetToggle = nil
                }
                .tapResetAction {
                    viewModel.d2CategoryCode = viewModel.d2EntirCode
                    viewModel.offset = 0
                    viewModel.send(action: .getFilterResult)
                    viewModel.tappedD2CategoryChips = nil
                    viewModel.sheetToggle = nil
                }
        }
        .padding(.horizontal, 24)
    }
}

//#Preview {
//    CategoryBottomSheet(viewModel: CategoryFilteredViewModel())
//}
