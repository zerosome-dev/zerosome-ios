//
//  MyReviewsListViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/10.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

class MyReviewsListViewModel: ObservableObject {
    enum Action {
        case getMyReviewList
    }
    
    private let reviewUsecase: ReviewUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(reviewUsecase: ReviewUsecase) {
        self.reviewUsecase = reviewUsecase
    }
    
    @Published var userReviewList: [ReviewDetailByMemberResult] = []
    @Published var reviewCnt: Int?
    @Published var isLoading: Bool = false
    @Published var hasMoreReviews: Bool = true
    @Published var offset: Int = 0
    @Published var limit: Int = 10
    
    func send(_ action: Action) {
        switch action {
        case .getMyReviewList:
            guard !isLoading && hasMoreReviews else { return }
            isLoading = true
            
            reviewUsecase.getMyReviewList(offset: offset, limit: limit)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        self.isLoading = false
                        debugPrint("get mypage user review list is failed \(failure.localizedDescription)")
                    }
                } receiveValue: { [weak self] result in
                    if result.content.reviewList.isEmpty {
                        self?.hasMoreReviews = false
                    } else {
                        self?.userReviewList.append(contentsOf: result.content.reviewList)
                        self?.reviewCnt = self?.userReviewList.count
                        self?.offset += 1
                    }
                    
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    }
}
