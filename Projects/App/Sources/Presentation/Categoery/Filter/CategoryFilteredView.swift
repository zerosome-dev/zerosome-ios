//
//  FilterCategoryView.swift
//  App
//
//  Created by 박서연 on 2024/07/03.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import FirebaseAnalytics

struct CategoryFilteredView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var viewModel: CategoryFilteredViewModel
    
    let navigationTtile: String
    let d2CategoryCode: String
    let d1CategoryCode: String
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 11, alignment: .center), count: 2)
    
//    init(
//        navigationTtile: String,
//        d2CategoryCode: String,
//        viewModel: CategoryFilteredViewModel,
//        d1CategoryCode: String
//    ) {
//        self.navigationTtile = navigationTtile
//        self.d2CategoryCode = d2CategoryCode
//        self.viewModel = viewModel
//        self.d1CategoryCode = d1CategoryCode
//    }
    
    var body: some View {
        ScrollView {
            VStack {
                CategoryListView(viewModel: viewModel)
                    .padding(.horizontal, 22)
                    .padding(.bottom, 8)
                DivideRectangle(height: 1, color: Color.neutral100)
                
                HStack {
                    ZSText("\(viewModel.productList.count)개의 상품", fontType: .body3, color: Color.neutral900)
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
                
                if viewModel.productList.isEmpty {
                    NoneFilterResultView()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.productList, id: \.id) { product in
                            ProductPreviewComponent(data: product)
                                .tap {
                                    let categoryName = viewModel.tappedD2CategoryChips?.name ?? ""
                                    router.navigateTo(.detailMainView(product.productId, categoryName))
                                    LogAnalytics.logProductD1Category(d1Category: navigationTtile)
                                    LogAnalytics.logProductD2Category(d2Category: categoryName)
                                }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else if viewModel.hasMoreProducts {
                            Color.clear
                                .onAppear {
                                    viewModel.send(action: .getFilterResult)
                                }
                        }
                    }
                    .padding(.horizontal, 22)
                }
            }
        }
        .onAppear {
            if viewModel.productList.isEmpty {
                viewModel.d2CategoryCode = d2CategoryCode
                viewModel.d1CategoryCode = d1CategoryCode
                viewModel.navigationTitle = navigationTtile
                viewModel.offset = 0
                viewModel.send(action: .getD2CategoryList)
                viewModel.send(action: .getZeroTagList)
                viewModel.send(action: .getBrandList)
                viewModel.send(action: .getFilterResult)
            }
        }
        .sheet(isPresented: $viewModel.updateToggle) {
            UpdateBottomSheet(viewModel: viewModel)
                .presentationDetents([.height(294)])
        }
        .ZSNavigationBackButtonTitle(self.navigationTtile) {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryFilteredView(viewModel: CategoryFilteredViewModel(initD2CategoryCode: "CTG001001", initD1CategoryCode: "CTG002", filterUsecase: FilterUsecase(filterRepoProtocol: FilterRepository(apiService: ApiService()))), navigationTtile: "과자/아이스크림", d2CategoryCode: "CTG001001", d1CategoryCode: "CTG002")
}
