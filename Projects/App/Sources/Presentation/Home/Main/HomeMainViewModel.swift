//
//  HomeMainViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

class HomeMainViewModel: ObservableObject {
    
    enum Action {
        case tobeReleased
        case cafe
    }
    
    private let homeUsecase: HomeUsecase
    private let filterUsecase: FilterUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        homeUsecase: HomeUsecase,
        filterUsecase: FilterUsecase
    ) {
        self.homeUsecase = homeUsecase
        self.filterUsecase = filterUsecase
    }
    
    @Published var tobeReleased: [HomeRolloutResult] = []
    @Published var homeCafe: [HomeCafeResult] = []
    @Published var totalCode: String = ""
    @Published var tappedCafeCategory: String = ""
    @Published var cafeCategoryList: [D2CategoryFilterResult] = []
    @Published var filteredCafe: [HomeCafeResult] = []
    @Published var cafeEntireCode = ""
   
    func send(action: Action) {
        switch action {
        case .tobeReleased:
            Task {
                homeUsecase.tobeReleaseProduct()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            debugPrint("🧪 \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] data in
                        self?.tobeReleased = data
                    })
                    .store(in: &cancellables)
            }
            
        case .cafe:
            homeUsecase.homeCafe()
                .receive(on: DispatchQueue.main)
                .flatMap { [weak self] cafeData -> AnyPublisher<[D2CategoryFilterResult], NetworkError> in
                    self?.homeCafe = cafeData
                    self?.filteredCafe = cafeData
                    return self?.filterUsecase
                        .getD1CategoryList(d1CategoryCode: cafeData.first?.d1CategoryId ?? "")
                        .eraseToAnyPublisher() ??
                    Fail(error: NetworkError.response).eraseToAnyPublisher()
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        debugPrint("🧪🧪 \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] categoryData in
                    self?.cafeCategoryList = categoryData.filter({ !$0.noOptionYn })
                    self?.cafeEntireCode = categoryData.filter { $0.noOptionYn }
                        .map { $0.d2CategoryCode }
                        .joined()
                })
                .store(in: &cancellables)
        }
    }
    
}
