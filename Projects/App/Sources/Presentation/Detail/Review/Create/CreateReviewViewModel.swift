//
//  CreateReviewViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/03.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine
import SwiftUI

class CreateReviewViewModel: ObservableObject {
    
    @Published var starCounting: Int = 0
    @Published var reviewEntity: ReviewEntity?
    @Published var text: String = ""
    @Published var review: ReviewCreateRequest?
    @Published var reviewResult: Bool?
    
    enum Action {
        case postReview
    }
    
    private let reviewUsecase: ReviewUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(reviewUsecase: ReviewUsecase) {
        self.reviewUsecase = reviewUsecase
    }
    
    func send(_ action: Action) {
        switch action {
        case .postReview:
            print("리뷰 등록")
            
            guard let product = reviewEntity else { return }
            print("리뷰 등록 💜")
            
            self.review = ReviewCreateRequest(
                productId: product.productId,
                rating: starCounting,
                contents: text
            )
            
            guard let data = self.review else { return }
            print("리뷰 등록💜💜")
            
            reviewUsecase.postReview(review: data)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("리뷰 등록💜💜💜")
                        break
                    case .failure(let failure):
                        print("리뷰 등록💜💜💜💜")
                        debugPrint("post review failure \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    print("리뷰 등록 성공")
                    print("리뷰 등록💜💜💜💜💜💜💜")
                    result ? (self.reviewResult = true) : (self.reviewResult = false)
                }
                .store(in: &cancellables)
        }
    }
}
