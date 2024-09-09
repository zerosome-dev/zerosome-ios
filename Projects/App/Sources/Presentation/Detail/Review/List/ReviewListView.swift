//
//  ReviewListView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine
import DesignSystem

struct ReviewListView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: ReviewListViewModel
    let productId: String
    let reviewEntity: ReviewEntity
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            CommonButton(title: "리뷰 작성", font: .subtitle1)
                .tap {
                    router.navigateTo(.creatReview(reviewEntity))
                    print("dd")
                }
                .padding(.horizontal, 22)
                .zIndex(1)
                
            ScrollView {
                ReviewScoreComponent(
                    heightPadding: 38,
                    radius: 8,
                    review: viewModel.averageReview ?? 0.0,
                    font: .heading1
                )
                .padding(.init(top: 10, leading: 22, bottom: 30, trailing: 22))
                
                LazyVStack(spacing: 0) {
                    ForEach($viewModel.reviewList, id: \.id) { $review in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                ZSText(review.nickname, fontType: .subtitle2, color: Color.neutral700)
                                Spacer()
                                ZSText(review.regDate, fontType: .body4, color: Color.neutral400)
                            }
                            
                            HStack(spacing: 4) {
                                StarComponent(rating: review.rating, size: 16)
                                ZSText("\(review.rating)", fontType: .label1)
                            }
                            
                            ZSText(review.reviewContents, fontType: .body2, color: Color.neutral700)
                                .lineLimit(review.more ? nil : 3)
                                .padding(.vertical, 12)

                            ZSText(review.more ? "접기" : "더보기", fontType: .body2, color: Color.neutral700)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onTapGesture {
                                    review.more.toggle()
                                }
                            
                            ZSText("신고", fontType: .body3, color: Color.neutral300)
                                .onTapGesture {
                                    viewModel.reportToggle = true
                                }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            } else if viewModel.hasMoreRevieww {
                                Color.clear
                                    .onAppear {
                                        viewModel.send(.getReviewList)
                                    }
                            }
                        }
                        .padding(.horizontal, 22)
                        
                        DivideRectangle(height: 1, color: Color.neutral50)
                            .opacity(review.id == viewModel.reviewList.last?.id ? 0 : 1)
                            .padding(.top, 20)
                            .padding(.bottom, 30)
                    }
                }
                .zIndex(1)
            }
        }
        .onAppear {
            viewModel.productId = productId
            viewModel.send(.getReviewList)
        }
        .scrollIndicators(.hidden)
        .ZSNavigationBackButtonTitle("상품 리뷰") {
            router.navigateBack()
        }
        .ZAlert(isShowing: $viewModel.reportToggle,
                type: .doubleButton(
                    title: "신고할까요?",
                    LButton: "닫기",
                    RButton: "신고하기"
                )
        , leftAction: {
            viewModel.reportToggle = false
        }, rightAction:  {
            viewModel.reportToggle = false
        })
    }
}

#Preview {
    ReviewListView(
        viewModel: ReviewListViewModel(
            reviewUsecase: ReviewUsecase(
                reviewProtocol: ReviewRepository(
                    apiService: ApiService()
                )
            )
        ),
        productId: "292",
        reviewEntity: .init(name: "", brand: "", productId: 0, image: "")
    )
}
