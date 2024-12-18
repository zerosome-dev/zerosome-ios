//
//  DetailMainViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Kingfisher
import FirebaseAnalytics

class DetailMainViewModel: ObservableObject {
    
    enum Action {
        case fetchData
    }
    
    @Published var navigationTitle: String = ""
    @Published var dataInfo: ProductDetailResponseResult?
    @Published var productId: Int = 0
    @Published var isNutrients: Bool = false
    @Published var reviewEntity: ReviewEntity?
    @Published var similarList: [SimilarProductResult] = []
    @Published var guestToggle: Bool = false
    
    private let detailUseCase: DetailUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        detailUseCase: DetailUsecase
    ) {
        self.detailUseCase = detailUseCase
    }
    
    func send(action: Action) {
        switch action {
        case .fetchData:
            Task {
                detailUseCase.getProductDetail(productId: productId)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let failure):
                            debugPrint("🧪 Fetch Product Detail Failure \(failure.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] data in
                        self?.dataInfo = data
                        self?.similarList = data.similarProductList
                        self?.reviewEntity = ReviewEntity(name: data.productName, brand: data.brandName, productId: data.productId, image: data.image)
                        
                        LogAnalytics.logProductName(name: data.productName)
                        LogAnalytics.logProductBrand(brand: data.brandName)
                    })
                    .store(in: &cancellables)
            }
        }
    }
}
