//
//  CreateReviewView.swift
//  App
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Kingfisher

struct SampleProduct {
    let name: String
    let brand: String
    let content: String
    
    static let sampleProduct = SampleProduct(name: "파워에이드", brand: "노브랜드", content: "상품입니다상품입니다상품입니다상품입니다")
}
    
class CreateReviewViewModel: ObservableObject {
    
    @Published var starCounting: Int = 0
    @Published var reviewEntity: ReviewEntity?
    @Published var text: String = ""
    @Published var review: ReviewCreateRequest?
    @Published var reviewResult: Bool?
    
    enum Action {
        case postReview
    }
    
    private let reviewUsecase: ReviewUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(reviewUsecase: ReviewUsecase) {
        self.reviewUsecase = reviewUsecase
    }
    
    func send(_ action: Action) {
        switch action {
        case .postReview:
            print("리뷰 등록")
            
            guard let product = reviewEntity else { return }
            print("리뷰 등록 💜")
            
            self.review = ReviewCreateRequest(
                productId: product.productId,
                rating: starCounting,
                contents: text
            )
            
            guard let data = self.review else { return }
            print("리뷰 등록💜💜")
            
            reviewUsecase.postReview(review: data)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("리뷰 등록💜💜💜")
                        break
                    case .failure(let failure):
                        print("리뷰 등록💜💜💜💜")
                        debugPrint("post review failure \(failure.localizedDescription)")
                    }
                } receiveValue: { result in
                    print("리뷰 등록 성공")
                    print("리뷰 등록💜💜💜💜💜💜💜")
                    result ? (self.reviewResult = true) : (self.reviewResult = false)
                }
                .store(in: &cancellables)
        }
    }
}

struct CreateReviewView: View {

    let data: ReviewEntity
    @ObservedObject var viewModel: CreateReviewViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var popup: PopupAction
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "작성 완료", font: .subtitle1)
                .enable(
                    // TODO: -  Button 조건 수정
                    viewModel.starCounting >= 1
                )
                .tap {
                    viewModel.send(.postReview)
                }
                .onReceive(viewModel.$reviewResult) { result in
                    DispatchQueue.main.async {
                        guard let toggle = result else { return }
                        
                        if !toggle {
                            popup.settingToggle(type: .failLogout)
                            popup.setToggle(for: .failLogout, true)
                        } else {
                            router.navigateBack()
                        }
                    }
                }
                .padding(.init(top: -2,leading: 22,bottom: 0,trailing: 22))
                .zIndex(1)
            
            ScrollView {
                VStack(spacing: 30) {
                    KFImage(URL(string: data.image))
                        .placeholder {
                            ProgressView()
                                .tint(Color.primaryFF6972)
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(spacing: 6) {
                        ZSText("[\(data.brand)]", fontType: .body2, color: Color.neutral500)
                        ZSText(data.name, fontType: .subtitle1, color: Color.neutral900)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral100)
                    VStack(spacing: 10){
                        ZSText("상품은 만족스러웠나요?", fontType: .subtitle1, color: .black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { index in
                                (index <= viewModel.starCounting ? ZerosomeAsset.ic_star_fill : ZerosomeAsset.ic_star_empty)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .onTapGesture {
                                        viewModel.starCounting = index
                                    }
                            }
                        }
                    }
                    
                    ZSTextEditor(
                        content: $viewModel.text,
                        placeholder: "제품에 대한 의견을 자유롭게 남겨주세요",
                        maxCount: 1000
                    )
                    .padding(22)
                }
                .padding(.bottom, 52)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.reviewEntity = data
        }
        .ZSnavigationBackButton {
            router.navigateBack()
        }
    }
}

#Preview {
    CreateReviewView(data: ReviewEntity(name: "name", brand: "brand", productId: 12, image: ""), viewModel: CreateReviewViewModel(reviewUsecase: ReviewUsecase(reviewProtocol: ReviewRepository(apiService: ApiService()))))
}
