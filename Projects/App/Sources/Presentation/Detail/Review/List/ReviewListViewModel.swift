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
    @Published var hasMoreRevieww: Bool = true
    
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
            guard !isLoading && hasMoreRevieww else { return }
            isLoading = true
            
            reviewUsecase.getProductReviewList(productId: productId, offset: offset, limit: limit)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("get review list failer! \(failure.localizedDescription)")
                        self.hasMoreRevieww = false
                    }
                } receiveValue: { [weak self] result in
                    guard let self = self else { return }
                    
                    if result.isEmpty {
                        self.hasMoreRevieww = false
                    } else {
                        self.reviewList.append(contentsOf: result)
                        self.offset += 1
                    }
                    
                    self.isLoading = false
                    self.averageReview = result.reduce(0) { $0 + $1.rating } / Double(result.count)
                }
                .store(in: &cancellables)
        }
    }
}

/*
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
 */
