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

struct MyReivewView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var popup: PopupAction
    @ObservedObject var viewModel: MyReivewViewModel
    let review: ReviewDetailByMemberResult
    
    var body: some View {
        ZStack(alignment: .bottom) {            
            buttonView()
            
            ScrollView {
                VStack(spacing: 30) {
                    KFImage(URL(string: review.productImage))
                        .placeholder {
                            ProgressView()
                                .tint(Color.primaryFF6972)
                        }
                        .resizable()
                        .frame(width: 240, height: 240)
                        .padding(.top, 10)
                    
                    VStack(spacing: 6) {
                        ZSText(review.brandName, fontType: .body2, color: Color.neutral500)
                        ZSText(review.productName, fontType: .subtitle1, color: Color.neutral900)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral100)
                    starView()
                    
                    ZSTextEditor(
                        content: $viewModel.content,
                        placeholder: "제품에 대한 의견을 자유롭게 남겨주세요",
                        maxCount: 1000,
                        disable: viewModel.editText
                    )
                    .padding(.horizontal, 22)
                    .onTapGesture {
                        viewModel.reviewFlag = true
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear {
                viewModel.review = self.review
                viewModel.send(.getContent)
            }
            .overlay(alignment: .topTrailing) { miniPop() }
            .onTapGesture {
                viewModel.isPresented = false
                UIApplication.shared.endEditing()
            }
            .ZSNavigationDoubleButton("내가 작성한 리뷰") {
                router.navigateBack()
            } rightAction: {
                viewModel.isPresented.toggle()
            }
            .onReceive(viewModel.$deleteResult) { result in
                guard let toggle = result else { return }
                
                if toggle {
                    router.navigateBack()
                    toast.settingToggle(type: .deleteReview)
                    toast.setToggle(for: .deleteReview, true)
                } else {
                    toast.settingToggle(type: .failNickname)
                    toast.setToggle(for: .failNickname, true)
                    router.navigateBack()
                }
            }
            .onReceive(viewModel.$modifyResult) { result in
                guard let toggle = result else { return }
                
                if toggle {
                    popup.settingToggle(type: .modifyReview)
                    popup.setToggle(for: .modifyReview, true)
                    router.navigateBack()
                } else {
                    popup.settingToggle(type: .failModifyReview)
                    popup.setToggle(for: .failModifyReview, true)
                    router.navigateBack()
                }
            }
            .ZAlert(isShowing: $viewModel.deleteAlert,
                    type: .doubleButton(
                        title: "리뷰를 삭제할까요?",
                        LButton: "닫기",
                        RButton: "삭제하기"
                    ),
            leftAction: {
                viewModel.deleteAlert = false
            }, rightAction: {
                viewModel.deleteAlert = false
                viewModel.send(.deleteReview)
            })
        }
    }
    
    @ViewBuilder func miniPop() -> some View {
        MypagePopup()
            .tapRemove {
                viewModel.isPresented = false
                viewModel.deleteAlert = true
            }
            .tapUpdate {
                viewModel.isPresented = false
                viewModel.editText = false
            }
            .opacity(viewModel.isPresented ? 1 : 0)
            .offset(x: -22)
    }
    
    @ViewBuilder func buttonView() -> some View {
        if viewModel.editText {
            EmptyView()

        } else {
            CommonButton(title: "수정 완료", font: .subtitle1)
                .tap {
                    viewModel.send(.modifyReview)
                }
                .zIndex(1)
                .padding(.horizontal, 22)
        }
    }
    
    @ViewBuilder func starView() -> some View {
        VStack(spacing: 10) {
            ZSText("상품은 어떠셨나요?", fontType: .subtitle1)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    (
                        index <= Int(viewModel.review?.rating ?? 0.0)
                        ? ZerosomeAsset.ic_star_fill
                        : ZerosomeAsset.ic_star_empty
                    )
                    .resizable()
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        viewModel.review?.rating = Double(index)
                    }
                }
            }
            .disabled(viewModel.editText)
        }
    }
}

#Preview {
    MyReivewView(viewModel: MyReivewViewModel(reviewUsecase: ReviewUsecase(reviewProtocol: ReviewRepository(apiService: ApiService()))), review: ReviewDetailByMemberResult(
        reviewId: 12,
        rating: 3.7,
        contents: "reviewContents",
        brandName: "brand",
        productName: "productname",
        productImage: "image",
        regDate: "date")
    )
}
