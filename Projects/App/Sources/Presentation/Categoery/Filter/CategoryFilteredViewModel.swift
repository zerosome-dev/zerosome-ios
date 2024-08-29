//
//  CategoryFilteredViewModel.swift
//  App
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

class CategoryFilteredViewModel: ObservableObject {
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String?
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    
    private let filterUsecase: FilterUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
//        category: String? = nil,
        filterUsecase: FilterUsecase
    ) {
//        self.category = category
        self.filterUsecase = filterUsecase
    }
    
    // MARK: - 바텀시트 새로 8/28
    @Published var d2CategoryTest: [D2CategoryFilterResult] = []
    @Published var zeroTagTest: [ZeroCategoryFilterResult] = []
    @Published var d2CategoryCode: String = ""
    @Published var tappedZeroTagChips: [TappedChips] = []
    
    // MARK: - 바텀시트 새로 8/29 - 브랜드
    @Published var brandTest: [BrandFilterResult] = []
    @Published var tappedBrandChips: [TappedChips] = []
    
    enum Action {
        case getBrandList
        case getZeroTagList
        case getD2CategoryList
        case getFilterResult
    }
    
    func send(action: Action) {
        switch action {
        case .getBrandList:
            print("브랜드 리스트")
            filterUsecase.getBrandList()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get Brand List for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.brandTest = data
                }
                .store(in: &cancellables)
            
        case .getZeroTagList:
            print("제로테그 리스트")
            filterUsecase.getZeroTagList()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get Zero Tage for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.zeroTagTest = data
                }
                .store(in: &cancellables)

            
        case .getD2CategoryList:
            print("d2Category 리스트")
            filterUsecase.getD2CategoryList(d2CategoryCode: self.d2CategoryCode)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get D2Category List for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.d2CategoryTest = data
                }
                .store(in: &cancellables)

            
        case .getFilterResult:
            print("필터 결과 리스트")
        }
    }
    
}
