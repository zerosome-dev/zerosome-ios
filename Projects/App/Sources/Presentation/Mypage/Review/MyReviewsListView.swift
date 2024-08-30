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
    
    func send(_ action: Action) {
        switch action {
        case .getMyReviewList:
            print("유저 작성 리뷰 목록 조회하기")
            
            reviewUsecase.getMyReviewList(offset: 0, limit: 10)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        debugPrint("get mypage user review list is failed \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    self.userReviewList = result.map({ $0.content }).flatMap({ $0.reviewList })
                    self.reviewCnt = result.map { $0.content }.first.map { $0.reviewCnt } // 작성한 리뷰수
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
            
            ForEach(viewModel.userReviewList, id: \.id) { data in
                VStack(spacing: 0) {
                    ZSText("\(data.regDate) 작성", fontType: .body3, color: Color.neutral400)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 11)
                    
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
                            ZSText(data.brand, fontType: .body3, color: Color.neutral500)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ZSText(data.productName, fontType: .subtitle2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                            HStack(spacing: 4) {
                                StarComponent(rating: data.rating, size: 16)
                                ZSText("\(data.rating)", fontType: .label1, color: Color.neutral700)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.vertical, -2)
                    }
                    .onTapGesture {
                        router.navigateTo(.myReivew(data))
                    }
                }
                .padding(.horizontal, 22)
                
                DivideRectangle(height: 1, color: Color.neutral50)
                    .padding(.vertical, 30)
//                    .opacity(review == 4 ? 0 : 1)
            }
        }
        .ZSNavigationBackButtonTitle("내가 작성한 리뷰") {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
        .onAppear {
//            viewModel.send(.getMyReviewList)
        }
    }
    
    @ViewBuilder func productInfo() -> some View {
        
    }
}

#Preview {
    MyReviewsListView(viewModel: MyReviewsListViewModel(reviewUsecase: ReviewUsecase(reviewProtocol: ReviewRepository(apiService: ApiService()))))
}
