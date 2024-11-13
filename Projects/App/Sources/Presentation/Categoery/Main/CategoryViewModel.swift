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
        case getEntireCode(D1CategoryResult)
    }
    
    @Published var filteredTitle: String = ""
    @Published var categoryList: [D1CategoryResult] = []
    @Published var entirCode: String = ""
    @Published var tapD2Category: D2CategoryResult?

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
            if categoryList.isEmpty {
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
                   }
                   .store(in: &cancellables)
            }
            
        case .tapCategoryTitle(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName

        case .tapD2CategoryItem(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName
            
        case .getEntireCode(let d1Category):
            self.entirCode = d1Category.d2Category.filter{ $0.d2CategoryName == "전체" }.map{ $0.d2CategoryCode }.joined()
        }
    }
}
