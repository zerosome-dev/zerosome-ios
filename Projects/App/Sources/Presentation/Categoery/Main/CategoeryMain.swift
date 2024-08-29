//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.categoryList, id: \.id) { d1Category in
                CategoryItemGridComponent(
                    tapData: $viewModel.tapData,
                    tapD2Category: $viewModel.tapD2Category,
                    data: d1Category
                )
                // 화면 이동할 때 네비 타이틀(전체 카테고리 + 필터ID)
                .tapTitle { // 전체 필터로 이동
                    viewModel.send(action: .tapCategoryTitle(d1Category))
                    viewModel.send(action: .getBrandNameForCafe(d1Category))
                    print("main 🏪🏪🏪 \(viewModel.entirCode)")
                    
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        viewModel.entirCode,
                        viewModel.brandFilter)
                    )
                }
                .tapItem { // 카테고리 아이템 탭했을 때
                    // 각 d2카테고리의 필터뷰로 이동
                    viewModel.send(action: .getBrandNameForCafe(d1Category))
                    viewModel.send(action: .tapD2CategoryItem(d1Category))
                    guard let tapD2Category = viewModel.tapD2Category else { return }
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        viewModel.entirCode,
                        viewModel.brandFilter)
                    )
                }
            }
        }
        .padding(.horizontal, 22)
        .ZSnavigationTitle("카테고리")
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.send(action: .getCategoryList)
        }
    }
}

#Preview {
    CategoryMainView(viewModel: CategoryViewModel(categoryUseCase: CategoryUsecase(categoryRepoProtocol: CategoryListRepository(apiService: ApiService()))))
}
