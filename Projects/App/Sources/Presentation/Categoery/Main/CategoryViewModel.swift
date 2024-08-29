//
//  CategoryViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    
    enum Action {
        case getCategoryList
        case tapCategoryTitle(D1CategoryResult)
        case tapD2CategoryItem(D1CategoryResult)
        case getBrandNameForCafe(D1CategoryResult)
    }
    
    @Published var isNutrients: Bool = false
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String = "전체"
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    @Published var tapData: Int? // Grid에서 tap한 Item의 코드(tapD2Category 서비용)
    
    // 카테고리
    @Published var categoryList: [D1CategoryResult] = []
    
    // title tap > 전체 코드를 사용해서 넘어가는 경우를 위한 전체 코드
    @Published var entirCode: String = "" // 각 카테고리 별 전체(카테고리) 코드
    @Published var tapD2Category: D2CategoryResult? // Grid에서 tap한 Item
    @Published var filteredTitle: String = "" // 다음 페이지의 제목
    
    // brand
    @Published var brandFilter: [String] = [] // api내에 브랜드 필터를 위함
        
    private let categoryUseCase: CategoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        categoryUseCase: CategoryUsecase
    ) {
        self.categoryUseCase = categoryUseCase
    }
}

extension CategoryViewModel {
    func send(action: Action) {
        switch action {
        case .getCategoryList:
            categoryUseCase.getCategoryList()
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let failure):
                       debugPrint("Failed action: CategoryList \(failure.localizedDescription)")
                   }
               } receiveValue: { [weak self] data in
                   self?.categoryList = data
//                        self?.entireCodeData = data.flatMap { d1CategoryResult in
//                            d1CategoryResult.d2Category.filter { d2CategoryResult in
//                                !d2CategoryResult.noOptionYn
//                            }
//                        } // [D1CategoryResult]
               }
               .store(in: &cancellables)
        case .tapCategoryTitle(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName
            self.entirCode = d1Category.d1CategoryCode

        case .tapD2CategoryItem(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName
            self.entirCode = d1Category.d1CategoryCode
            
        case .getBrandNameForCafe(let d1Category):
            self.brandFilter = d1Category.d2Category.filter { $0.d2CategoryName != "전체" }.map { $0.d2CategoryName }
            print("🩵🩵🩵🩵brandFilterbrandFilter: \(self.brandFilter)🩵🩵🩵🩵")
        }
    }
}
