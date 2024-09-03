//
//  ReviewListViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/03.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import SwiftUI

class ReviewListViewModel: ObservableObject {
    
    enum Action {
        case getReviewList
    }
    
    @Published var productId: String = ""
    @Published var reviewList: [ReviewDetailResult] = []
    @Published var averageReview: Double?
    @Published var reportToggle: Bool = false
    
    private let reviewUsecase: ReviewUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        reviewUsecase: ReviewUsecase
    ) {
        self.reviewUsecase = reviewUsecase
    }
    
    func send(_ action: Action) {
        switch action {
        case .getReviewList:
            reviewUsecase.getProductReviewList(productId: productId, offset: 0, limit: 10)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("get review list failer! \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    self.reviewList = result
                    self.averageReview = result.reduce(0) { $0 + $1.rating } / Double(result.count)
                }
                .store(in: &cancellables)
        }
    }
    
}
