//
//  MyReviewsView.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Kingfisher

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

struct MyReviewsListView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: MyReviewsListViewModel
    
    var body: some View {
        ScrollView {
            ZSText("\(viewModel.reviewCnt ?? 0)개의 리뷰를 작성했어요", fontType: .heading1, color: Color.neutral900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10,leading: 22,bottom: 30,trailing: 22))
            
            VStack(spacing: 0) {
                ForEach(viewModel.userReviewList, id: \.id) { data in
                    VStack(spacing: 0) {
                        ZSText("\(data.regDate) 작성", fontType: .body3, color: Color.neutral400)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 11)
                        
                        productInfo(data: data)
                        .onTapGesture {
                            router.navigateTo(.myReivew(data))
                        }
                    }
                    .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral50)
                        .padding(.vertical, 30)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Color.primaryFF6972)
                        .padding()
                } else if viewModel.hasMoreReviews {
                    Color.clear
                        .onAppear {
                            viewModel.send(.getMyReviewList)
                        }
                }
            }
        }
        .ZSNavigationBackButtonTitle("내가 작성한 리뷰") {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.send(.getMyReviewList)
        }
    }
    
    @ViewBuilder func productInfo(data: ReviewDetailByMemberResult) -> some View {
        HStack {
            KFImage(URL(string: data.productImage))
                .placeholder {
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            ProgressView().tint(Color.primaryFF6972)
                        }
                }
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(spacing: 0) {
                ZSText("[\(data.brandName)]", fontType: .body3, color: Color.neutral500)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZSText(data.productName, fontType: .subtitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Spacer()
                
                HStack(spacing: 4) {
                    StarComponent(rating: data.rating, size: 16)
                    ZSText("\(data.rating)", fontType: .subtitle2, color: Color.neutral700)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.vertical, -2)
        }
    }
}

#Preview {
    MyReviewsListView(viewModel: MyReviewsListViewModel(reviewUsecase: ReviewUsecase(reviewProtocol: ReviewRepository(apiService: ApiService()))))
}
