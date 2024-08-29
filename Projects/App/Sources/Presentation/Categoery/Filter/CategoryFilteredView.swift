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
    @ObservedObject var viewModel: CategoryFilteredViewModel
    
    let navigationTtile: String
    let d2CategoryCode: String
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 11, alignment: .center), count: 2)
    
    init(
        navigationTtile: String,
        d2CategoryCode: String,
        viewModel: CategoryFilteredViewModel
    ) {
        self.navigationTtile = navigationTtile
        self.d2CategoryCode = d2CategoryCode
        self.viewModel = viewModel
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
                
//                LazyVGrid(columns: columns) {
//                    ForEach(0..<10, id: \.self) { index in
//                        ProductPreviewComponent()
//                    }
//                }
//                .padding(.horizontal, 22)
            }
        }
        .onAppear {
            viewModel.d2CategoryCode = d2CategoryCode
            viewModel.navigationTitle = navigationTtile
//            viewModel.send(action: .getZeroTagList)
//            viewModel.send(action: .getBrandList)
            viewModel.send(action: .getD2CategoryList)
//            viewModel.send(action: .getFilterResult)
        }
        .sheet(isPresented: $viewModel.updateToggle) {
            UpdateBottomSheet(filterVM: viewModel)
                .presentationDetents([.height(294)])
        }
        .ZSNavigationBackButtonTitle(self.navigationTtile) {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryFilteredView(navigationTtile: "과자/아이스크림", d2CategoryCode: "CTG005", viewModel: CategoryFilteredViewModel(filterUsecase: FilterUsecase(filterRepoProtocol: FilterRepository(apiService: ApiService()))))
}
