//
//  MyReivewViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/10.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

class MyReivewViewModel: ObservableObject {
    
    enum Action {
        case deleteReview
        case modifyReview
        case getContent
    }
    
    private let reviewUsecase: ReviewUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(reviewUsecase: ReviewUsecase) {
        self.reviewUsecase = reviewUsecase
    }
    
    @Published var review: ReviewDetailByMemberResult?
    @Published var content: String = ""
    @Published var isPresented: Bool = false
    @Published var deleteAlert: Bool = false
    @Published var deleteResult: Bool?
    @Published var editText: Bool = true
    @Published var reviewFlag: Bool = false
    @Published var modifyAlert: Bool = false
    @Published var modifyResult: Bool?
    
    func send(_ action: Action) {
        switch action {
        case .getContent:
            guard let data = review else { return }
            self.content = data.contents
            
        case .deleteReview:
            guard let data = review else { return }
            reviewUsecase.deleteReview(reviewId: data.reviewId)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        debugPrint("💩delete?? \(error.localizedDescription)")
                        self.deleteResult = false
                    }
                } receiveValue: { [weak self] result in
                    debugPrint("💩delete result? \(result)")
                    self?.deleteResult = result
                }
                .store(in: &cancellables)
            
        case .modifyReview:
            guard let data = review else { return }
            reviewUsecase.modifyReview(
                reviewId: data.reviewId,
                modifyReview: ReviewModifyRequest(
                    contents: self.content,
                    modifyContents: true,
                    rating: data.rating)
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.modifyResult = false
                    debugPrint("💩fail to modify review \(error.localizedDescription)")
                }
            } receiveValue: { result in
                print("💩modify result \(result)")
                self.modifyResult = result
            }
            .store(in: &cancellables)
        }
    }
}
