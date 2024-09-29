//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import FirebaseAnalytics

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.categoryList, id: \.id) { d1Category in
                CategoryItemGridComponent(
                    tapD2Category: $viewModel.tapD2Category,
                    data: d1Category
                )
                .tapTitle {
                    viewModel.send(action: .tapCategoryTitle(d1Category))
                    viewModel.send(action: .getEntireCode(d1Category))
                    
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        viewModel.entirCode,
                        d1Category.d1CategoryCode)
                    )
                }
                .tapItem {
                    viewModel.send(action: .tapD2CategoryItem(d1Category))
                    LogAnalytics.logProductD1Category(d1Category: d1Category.d1CategoryName)
                    guard let tapD2Category = viewModel.tapD2Category else { return }
                    LogAnalytics.logProductD2Category(d2Category: tapD2Category.d2CategoryName)
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        tapD2Category.d2CategoryCode,
                        d1Category.d1CategoryCode)
                    )
                }
                .padding(.horizontal, 22)
                
                DivideRectangle(height: 12, color: Color.neutral50)
                    .padding(.vertical, 30)
                    .opacity(d1Category == viewModel.categoryList.last ? 0 : 1)
            }
            Spacer()
        }
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
