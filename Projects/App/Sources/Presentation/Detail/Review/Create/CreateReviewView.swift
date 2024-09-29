//
//  CreateReviewView.swift
//  App
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct CreateReviewView: View {

    let data: ReviewEntity
    @StateObject var viewModel: CreateReviewViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var popup: PopupAction
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "작성 완료", font: .subtitle1)
                .enable(
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
                                (
                                    index <= viewModel.starCounting
                                    ? ZerosomeAsset.ic_star_fill
                                    : ZerosomeAsset.ic_star_empty
                                )
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
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .ZSnavigationBackButton {
            router.navigateBack()
        }
    }
}

#Preview {
    CreateReviewView(data: ReviewEntity(name: "name", brand: "brand", productId: 12, image: ""), viewModel: CreateReviewViewModel(reviewUsecase: ReviewUsecase(reviewProtocol: ReviewRepository(apiService: ApiService()))))
}
