//
//  MyReivewView.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine
import DesignSystem
import Kingfisher

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
            print("💩 \(self.content)")
            
        case .deleteReview:
            guard let data = review else { return }
            reviewUsecase.deleteReview(reviewId: data.reviewId)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        self.deleteResult = false
                    }
                } receiveValue: { [weak self] result in
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
                    debugPrint("fail to modify review \(error.localizedDescription)")
                }
            } receiveValue: { result in
                self.modifyResult = result
            }
            .store(in: &cancellables)
        }
    }
}

struct MyReivewView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var popup: PopupAction
    @ObservedObject var viewModel: MyReivewViewModel
    let review: ReviewDetailByMemberResult
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                
                Spacer()
            }
            .onAppear {
                viewModel.review = self.review
                viewModel.send(.getContent)
            }
            .scrollIndicators(.hidden)
            .overlay(alignment: .topTrailing) { miniPop() }
            .onTapGesture { viewModel.isPresented = false }
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
            
            buttonView()
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
                    print("수정중주줒우중")
                    viewModel.send(.modifyReview)
                }
                .padding(.horizontal, 22)
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
