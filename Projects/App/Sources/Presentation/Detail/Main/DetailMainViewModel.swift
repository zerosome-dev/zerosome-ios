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

class DetailMainViewModel: ObservableObject {
    
    enum Action {
        case fetchData
        case tapNutrients
    }
    
    @Published var dataInfo: ProductDetailResponseResult?
    @Published var productId: Int = 0
    @Published var isNutrients: Bool = false
    @Published var reviewEntity: ReviewEntity?
    @Published var nutrientEnity: [NutrientEntity] = []
    
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
                await detailUseCase.getProductDetail(productId: productId)
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
                        self?.reviewEntity = ReviewEntity(name: data.productName, brand: data.brandName, productId: data.productId, image: data.image)
                    })
                    .store(in: &cancellables)
            }
        case .tapNutrients:
            guard let data = dataInfo else { return }
            
            data.nutrientList.forEach({ [weak self] value in
                let newData = NutrientEntity(
                    nutrientName: value.nutrientName,
                    servings: value.servings,
                    amount: value.amount,
                    servingsStandard: value.servingsStandard,
                    amountStandard: value.amountStandard
                )
                self?.nutrientEnity.append(newData)
            })
        }
    }
}
