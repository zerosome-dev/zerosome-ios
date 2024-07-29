//
//  CategoryChoiceView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

enum CategoryDetail: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case category = "전체" // Defalut를 전체로 설정
    case brand = "브랜드"
    case zeroTag = "제로태그"
}

struct CategoryListView: View {
    
    @ObservedObject var viewModel: CategoryFilteredViewModel
    let rows = Array(repeating: GridItem(.flexible()), count: 1)
    let action: (() -> Void)?

    init (
        action: (() -> Void)? = nil,
        viewModel: CategoryFilteredViewModel
    ) {
        self.viewModel = viewModel
        self.action = action
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 6) {
                ForEach(CategoryDetail.allCases, id: \.self) { type in
                    HStack(spacing: 2) {
                        Text(getTagTitle(type))
                            .applyFont(font: .label1)
                        
                        ZerosomeAsset.ic_arrow_bottom
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .onTapGesture {
                        viewModel.sheetToggle = type
                    }
                    .sheet(item: $viewModel.sheetToggle) { category in
                        switch category {
                        case .brand:
                            BrandBottomSheet(viewModel: viewModel)
                                .presentationDetents([.height(540)])
                        case .category:
                            CategoryBottomSheet(viewModel: viewModel)
                                .presentationDetents([.height(540)])
                        case .zeroTag:
                            ZeroTagBottomSheet(viewModel: viewModel)
                                .presentationDetents([.height(540)])
                        }
                    }
                    .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            print("SY!!!! List vm.category \(viewModel.category)")
        }
    }
    
    private func getTagTitle(_ tag: CategoryDetail) -> String {
        switch tag {
        case .category:
//            let title = viewModel.tapData.isEmpty ? "전체" : viewModel.tapData
            let title = viewModel.category.isEmpty ? "전체" : viewModel.category
            return viewModel.category
        case .brand:
            let count = viewModel.brand.count
            let brand = viewModel.brand
            let title = viewModel.brand.isEmpty ? "브랜드"
            : count == 1 ? brand[0] : "\(brand[0]) 외 \(count)"
            
            return title
        case .zeroTag:
            let count = viewModel.zeroTag.count
            let zeroTag = viewModel.zeroTag
            
            let title = viewModel.zeroTag.isEmpty ? "제로태그"
            : count == 1 ? zeroTag[0] : "\(zeroTag[0]) 외 \(count)"
            
            return title
        }
    }
}

#Preview {
    CategoryListView(viewModel: CategoryFilteredViewModel())
}
