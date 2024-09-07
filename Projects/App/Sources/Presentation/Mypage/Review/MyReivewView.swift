//
//  MyReivewView.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

class MyReivewViewModel: ObservableObject {
    @Published var review: ReviewDetailByMemberResult
    @Published var isPresented: Bool = false
    @Published var isAlert: Bool = false
    
    init(review: ReviewDetailByMemberResult) {
        self.review = review
    }
}
struct MyReivewView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: MyReivewViewModel
    @State private var isPresented: Bool = false
    @State private var isAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                KFImage(URL(string: viewModel.review.productImage))
                    .resizable()
                    .frame(width: 240, height: 240)
                    .padding(.top, 10)
                
                VStack(spacing: 6) {
                    ZSText(viewModel.review.brandName, fontType: .body2, color: Color.neutral500)
                    ZSText(viewModel.review.productName, fontType: .subtitle1, color: Color.neutral900)
                        .lineLimit(1)
                } 
                .padding(.horizontal, 22)
                
                DivideRectangle(height: 1, color: Color.neutral100)
                
                VStack(spacing: 10) {
                    ZSText("상품은 어떠셨나요?", fontType: .subtitle1)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            (index <= Int(viewModel.review.rating) 
                             ? ZerosomeAsset.ic_star_fill
                             : ZerosomeAsset.ic_star_empty)
                                .resizable()
                                .frame(width: 36, height: 36)
                                .onTapGesture {
                                    viewModel.review.rating = Double(index)
                                }
                        }
                    }
                }
                
                ZSTextEditor(
                    content: $viewModel.review.reviewContents,
                    placeholder: "제품에 대한 의견을 자유롭게 남겨주세요",
                    maxCount: 1000,
                    disable: true
                )
                .padding(.horizontal, 22)
            }
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topTrailing) { popup() }
        .onTapGesture { isPresented = false }
        .ZSNavigationDoubleButton("내가 작성한 리뷰") {
            router.navigateBack()
        } rightAction: {
            viewModel.isPresented.toggle()
        }
        .ZAlert(isShowing: $viewModel.isAlert,
                type: .doubleButton(
                    title: "리뷰를 삭제할까요?",
                    LButton: "닫기",
                    RButton: "삭제하기"
                ),
        leftAction: {
            viewModel.isAlert = false
        }, rightAction: {
            viewModel.isAlert = false
            router.replaceNavigationStack(.mypageReviewList)
        })
    }
    
    @ViewBuilder func popup() -> some View {
        MypagePopup()
            .tapRemove {
                print("리뷰 삭제")
                viewModel.isPresented = false
                viewModel.isAlert = true
            }
            .tapUpdate {
                print("리뷰 수정")
                viewModel.isPresented = false
                router.navigateTo(.mypageReviewList)
            }
            .opacity(viewModel.isPresented ? 1 : 0)
            .offset(x: -22)
    }
}

#Preview {
    MyReivewView(viewModel: MyReivewViewModel(
        review: ReviewDetailByMemberResult(
            reviewId: 12,
            rating: 3.7,
            reviewContents: "reviewContents",
            brandName: "brand",
            productName: "productname",
            productImage: "image",
            regDate: "date")
    )
    )
}
