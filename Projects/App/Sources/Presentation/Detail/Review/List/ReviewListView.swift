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
    @EnvironmentObject var authViewModel: AuthViewModel
    let productId: String
    let reviewEntity: ReviewEntity
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            CommonButton(title: "리뷰 작성", font: .subtitle1)
                .tap {
                    if authViewModel.authenticationState == .guest {
                        viewModel.guestReview = true
                    } else {
                        router.navigateTo(.creatReview(reviewEntity))
                    }
                }
                .padding(.horizontal, 22)
                .zIndex(1)
                
            ScrollView {
                totalStarView()
                
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
                               
                            if review.reviewContents.count > 80 {
                                ZSText(review.more ? "접기" : "더보기", fontType: .body2, color: Color.neutral700)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .onTapGesture {
                                        review.more.toggle()
                                    }
                            } else {
                                EmptyView()
                            }
                            
                            ZSText("신고", fontType: .body3, color: Color.neutral300)
                                .onTapGesture {
                                    if authViewModel.authenticationState == .guest {
                                        viewModel.guestReport = true
                                    } else {
                                        viewModel.reportToggle = true
                                    }
                                }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            } else if viewModel.hasMoreReview {
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
                .padding(.bottom, 40)
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
        .ZAlert(
            isShowing: $viewModel.guestReview,
            type: .doubleButton(
                title: "리뷰 작성은 로그인이 필요해요.\n로그인 하시겠어요?",
                LButton: "닫기",
                RButton: "로그인하기"
            ), leftAction: {
                viewModel.guestReview = false
            }) {
                viewModel.guestReview = false
                router.popToRoot()
                authViewModel.authenticationState = .initial
            }
            .ZAlert(
                isShowing: $viewModel.guestReport,
                type: .doubleButton(
                    title: "신고하기는 로그인이 필요해요.\n로그인 하시겠어요?",
                    LButton: "닫기",
                    RButton: "로그인하기"
                ), leftAction: {
                    viewModel.guestReport = false
                }) {
                    viewModel.guestReport = false
                    router.popToRoot()
                    authViewModel.authenticationState = .initial
                }
    }
    
    @ViewBuilder
    private func totalStarView() -> some View {
        VStack(spacing:2) {
            ZSText(String(format: "%.1f", viewModel.averageReview ?? 0.0), fontType: .heading1)
            StarComponent(rating: viewModel.averageReview, size: 16)
        }
        .padding(.vertical, 38)
        .frame(maxWidth: .infinity)
        .background(Color.neutral50)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.init(top: 10, leading: 22, bottom: 30, trailing: 22))
    }
    
    @ViewBuilder
    private func itemStarView(rating: Binding<Double>) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                (index < Int(round(rating.wrappedValue)) ? ZerosomeAsset.ic_star_fill : ZerosomeAsset.ic_star_empty)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
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
