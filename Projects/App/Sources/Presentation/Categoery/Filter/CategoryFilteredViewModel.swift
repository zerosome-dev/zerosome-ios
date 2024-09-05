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
    
    enum Action {
        case getD2CategoryList
        case getBrandList
        case getZeroTagList
        case getFilterResult
    }
    
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String?
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    
    private let filterUsecase: FilterUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        filterUsecase: FilterUsecase
    ) {
        self.filterUsecase = filterUsecase
    }
    
    // MARK: - 바텀시트 새로 8/28
    @Published var zeroTagTest: [ZeroCategoryFilterResult] = []
    @Published var d2CategoryCode: String = ""
    @Published var tappedZeroTagChips: [TappedChips] = []
    
    // MARK: - 바텀시트 새로 8/29 - 브랜드
    @Published var brandTest: [BrandFilterResult] = []
    @Published var tappedBrandChips: [TappedChips] = []
    
    // MARK: - 바텀시트 새로 8/29 - 카테고리
    @Published var d2CategoryTest: [D2CategoryFilterResult] = []
    @Published var tappedD2CategoryChips: TappedChips?
    
    // 넘어오는 데이터
    @Published var navigationTitle: String = ""
    
    // 필터 결과
    @Published var filteredProducts: OffsetFilteredProductResult?
    @Published var productList: [FilteredProductResult] = []
}

extension CategoryFilteredViewModel {
    
    func send(action: Action) {
        switch action {
        case .getD2CategoryList:
            print("d2Category 리스트")
            filterUsecase.getD2CategoryList(d2CategoryCode: self.d2CategoryCode)
                .receive(on: DispatchQueue.main)
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
            
        case .getBrandList:
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
            
        case .getFilterResult:
            print("필터 결과 리스트")
            filterUsecase.getFilterdProduct(
                offset: nil,
                limit: nil,
                d2CategoryCode: d2CategoryCode,
                orderType: update.orderType,
                brandList: tappedBrandChips.map({ $0.code }),
                zeroCtgList: tappedZeroTagChips.map({ $0.code })
            )
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let failure):
                    debugPrint("하위 카테고리별 상품 목록 조회 실패 > \(failure.localizedDescription)")
                }
            } receiveValue: { [weak self] data in
                self?.filteredProducts = data
                self?.productList = data.content
            }
            .store(in: &cancellables)
        }
    }
}
