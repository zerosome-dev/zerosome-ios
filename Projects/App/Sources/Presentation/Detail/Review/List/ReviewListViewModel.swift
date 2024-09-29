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
    @Published var offset: Int = 0
    @Published var limit: Int = 10
    @Published var isLoading: Bool = false
    @Published var hasMoreReview: Bool = true
    
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
            guard !isLoading && hasMoreReview else { return }
            isLoading = true
            
            reviewUsecase.getProductReviewList(productId: productId, offset: offset, limit: limit)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("get review list failer! \(failure.localizedDescription)")
                        self.hasMoreReview = false
                    }
                } receiveValue: { [weak self] result in
                    guard let self = self else { return }
                    
                    if result.content.isEmpty {
                        self.hasMoreReview = false
                    } else {
                        self.reviewList.append(contentsOf: result.content)
                        self.offset += 1
                    }
                                        
                    self.isLoading = false
                    self.averageReview = self.reviewList.map { $0.rating }.reduce(0, +) / Double(self.reviewList.count)
                }
                .store(in: &cancellables)
        }
    }
}
