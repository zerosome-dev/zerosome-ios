//
//  FilterCategoryView.swift
//  App
//
//  Created by 박서연 on 2024/07/03.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CategoryFilteredView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel: CategoryFilteredViewModel
    
    let type: String
    let tag: String?
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 11, alignment: .center), count: 2)
    
    init(
        type: String,
        tag: String? = nil
    ) {
        self.type = type
        self.tag = tag
        _viewModel = StateObject(wrappedValue: CategoryFilteredViewModel(category: tag ?? "전체"))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CategoryListView(viewModel: viewModel)
                    .padding(.horizontal, 22)
                    .padding(.bottom, 8)
                DivideRectangle(height: 1, color: Color.neutral100)
                
                HStack {
                    ZSText("(32)개의 상품", fontType: .body3, color: Color.neutral900)
                    Spacer()
                    HStack(spacing: 2) {
                        Text("\(viewModel.update.rawValue)")
                        ZerosomeAsset.ic_arrow_bottom
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .onTapGesture {
                        viewModel.updateToggle.toggle()
                    }
                }
                .applyFont(font: .body3)
                .padding(.horizontal, 22)
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<10, id: \.self) { index in
                        ProductPreviewComponent()
                    }
                }
                .padding(.horizontal, 22)
            }
        }
        .sheet(isPresented: $viewModel.updateToggle){
            UpdateBottomSheet(filterVM: viewModel)
                .presentationDetents([.height(294)])
        }
        .ZSNavigationBackButtonTitle("생수/음료") {
            // TODO: - navititle 여기에 type 예정
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
        .onAppear {
            guard let catergoryTag = tag else { return }
            viewModel.category = catergoryTag
        }
    }
}

#Preview {
    CategoryFilteredView(type: "생수/음료", tag: "탄산수")
}
