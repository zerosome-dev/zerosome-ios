//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    @Published var isNutrients: Bool = false
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String = "전체"
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    @Published var tapData: String = ""
    
    enum Action {
        case getCategoryList
    }
    
    private let categoryUseCase: CategoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        categoryUseCase: CategoryUsecase
    ) {
        self.categoryUseCase = categoryUseCase
    }
    
    @Published var categoryList: [D1CategoryResult]?
    
    func send(action: Action) {
        switch action {
        case .getCategoryList:
            Task {
                await categoryUseCase.getCategoryList()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let failure):
                            debugPrint("Failed action: CategoryList \(failure.localizedDescription)")
                        }
                    } receiveValue: { [weak self] data in
                        print("💛💛💛💛💛 카테고리 목록!!!\(self?.categoryList) 💛💛💛💛💛")
                        self?.categoryList = data
                    }
                    .store(in: &cancellables)
                
            }
        }
    }
}

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: CategoryViewModel
    @State private var tapData: String = ""
    
    var body: some View {
        ScrollView {
            CategoryGridComponent(
                data: ZeroDrinkSampleData.drinkType,
                title: "생수/음료",
                last: false,
                after: true,
                tapData: $viewModel.category
            )
            .tapPageAction { router.navigateTo(.categoryFilter("생수/음료", viewModel.category)) }
            .padding(.top, 20)
            
            CategoryGridComponent(
                data: ZeroDrinkSampleData.cafeType,
                title: "카페음료",
                last: false,
                after: true,
                tapData: $viewModel.category
            )
            .tapPageAction { router.navigateTo(.categoryFilter("카페음료", viewModel.category)) }
            
            CategoryGridComponent(
                data: ZeroDrinkSampleData.snackType,
                title: "과자/아이스크림",
                last: true,
                after: true,
                tapData: $viewModel.category)
            .tapPageAction { router.navigateTo(.categoryFilter("과자/아이스크림", viewModel.category)) }
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
