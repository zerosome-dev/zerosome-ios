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
        case recordSheet
    }
    
    private let filterUsecase: FilterUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        initD2CategoryCode: String,
        initD1CategoryCode: String,
        filterUsecase: FilterUsecase
    ) {
        self.filterUsecase = filterUsecase
        self.d1CategoryCode = initD1CategoryCode
        self.d2CategoryCode = initD2CategoryCode
//        loadInitialProducts()
    }

    @Published var d2CategoryCode: String
    @Published var d1CategoryCode: String
    @Published var navigationTitle: String = ""
    
    @Published var d2CategoryList: [D2CategoryFilterResult] = []
    @Published var tappedD2CategoryChips: TappedChips?
    @Published var brandList: [BrandFilterResult] = []
    @Published var tappedBrandChips: [TappedChips] = []
    @Published var zeroTagList: [ZeroCategoryFilterResult] = []
    @Published var tappedZeroTagChips: [TappedChips] = []
    @Published var filteredProducts: OffsetFilteredProductResult?
    @Published var productList: [FilteredProductResult] = []
    
    // MARK: - BottomSheet action
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    @Published var sheetToggle: CategoryDetail? = nil
    @Published var lastDismissedSheet: CategoryDetail?
    
    // 무한 스크롤 테스트
    @Published var isLoading = false
    @Published var hasMoreProducts = true // 더 불러올 데이터가 있는지 여부
    
    @Published var offset = 0
    @Published var limit = 10
    
    // MARK: - flag
    @Published var d2CategoryListFlag: TappedChips?
    @Published var brandListFlag: [TappedChips] = []
    @Published var zeroTagListFlag: [TappedChips] = []
    @Published var d2EntirCode: String = ""
}

extension CategoryFilteredViewModel {
    
    func send(action: Action) {
        switch action {
        case .recordSheet:
            guard let type = sheetToggle else { return }
            lastDismissedSheet = type
            
        case .getD2CategoryList:
            filterUsecase.getD1CategoryList(d1CategoryCode: self.d1CategoryCode)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get D2Category List for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.d2CategoryList = data.filter({ !$0.noOptionYn })
                    self?.d2EntirCode = data.filter({ $0.noOptionYn }).map({ $0.d2CategoryCode }).joined()
                    let temp = data.filter { $0.d2CategoryCode == self?.d2CategoryCode }
                    guard let tapped = temp.first else { return }
                    self?.tappedD2CategoryChips = TappedChips(name: tapped.d2CategoryName, code: tapped.d2CategoryName)
                }
                .store(in: &cancellables)
            
        case .getBrandList:
            filterUsecase.getBrandList(d2CategoryCode: self.d2CategoryCode)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get Brand List for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.brandList = data
                }
                .store(in: &cancellables)
            
        case .getZeroTagList:
            filterUsecase.getZeroTagList()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("Get Zero Tage for Filter Failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] data in
                    self?.zeroTagList = data
                }
                .store(in: &cancellables)
            
        case .getFilterResult:
            if self.offset == 0  {
                productList.removeAll()
                hasMoreProducts = true
            }
            
            guard !isLoading && hasMoreProducts else { return }
            isLoading = true
            filterUsecase.getFilterdProduct(
                offset: offset,
                limit: limit,
                d2CategoryCode: d2CategoryCode,
                orderType: update.orderType,
                brandList: tappedBrandChips.map({ $0.code }),
                zeroCtgList: tappedZeroTagChips.map({ $0.code })
            )
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let failure):
                    debugPrint("상품 목록 조회 실패 > \(failure.localizedDescription)")
                    self.isLoading = false
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                
                // 더 이상의 데이터가 없는 경우
                if data.content.isEmpty {
                    self.hasMoreProducts = false
                } else {
                    self.productList.append(contentsOf: data.content)
                    self.offset += 1 // offset을 증가시켜 다음 데이터 호출
                }
                
                self.isLoading = false
            }
            .store(in: &cancellables)
            
//            filterUsecase.getFilterdProduct(
//                offset: nil,
//                limit: nil,
//                d2CategoryCode: d2CategoryCode,
//                orderType: update.orderType,
//                brandList: tappedBrandChips.map({ $0.code }),
//                zeroCtgList: tappedZeroTagChips.map({ $0.code })
//            )
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion {
//                case .finished: break
//                case .failure(let failure):
//                    debugPrint("하위 카테고리별 상품 목록 조회 실패 > \(failure.localizedDescription)")
//                }
//            } receiveValue: { [weak self] data in
//                self?.filteredProducts = data
//                self?.productList = data.content
//            }
//            .store(in: &cancellables)
        }
    }
}
