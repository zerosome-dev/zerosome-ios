//
//  ProductDetailView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Kingfisher

struct DetailMainView: View {

    let productId: Int
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @StateObject private var viewModel = DetailMainViewModel(
        detailUseCase: DetailUsecase(
            detailRepoProtocol: DetailRepository(
                apiService: ApiService()
            )
        )
    )
    
    init(productId: Int) {
        self.productId = productId
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "리뷰 작성", font: .subtitle2)
                .tap {
                    viewModel.send(action: .fetchReviewData)
                    guard let reviewEntity = viewModel.reviewEntity else { return }
                    print(reviewEntity)
                    router.navigateTo(.creatReview(reviewEntity))
                }
                .environmentObject(toast)
                .padding(.horizontal, 22)
                .zIndex(1)
            
            GeometryReader { geomtry in
                let size = geomtry.size
                ScrollView {
                    KFImage(URL(string: viewModel.dataInfo?.image ?? ""))
                        .placeholder {
                            ProgressView()
                                .tint(Color.primaryFF6972)
                        }
                        .resizable()
                        .frame(width: size.width, height: size.width)

                    VStack(spacing: 30) {
                        ProductInfoView(viewModel: viewModel)
                        DivideRectangle(height: 12, color: Color.neutral50)
                        
                        CommonTitle(
                            title: "제품 영양 정보",
                            type: .image,
                            imageTitle: ZerosomeAsset.ic_arrow_after
                        )
                        .imageAction { viewModel.isNutrients = true }
                        .padding(.horizontal, 22)
                        .sheet(isPresented: $viewModel.isNutrients) {
                            NutrientsBottomSheet(viewModel: viewModel)
                                .presentationDetents([.height(710)])
                        }
                        
                        DivideRectangle(height: 12, color: Color.neutral50)
                        
                        OffLineStoreView(offlineStore: viewModel.dataInfo?.offlineStoreList ?? [])
                        OnlineStoreView(onlineStore: viewModel.dataInfo?.onlineStoreList ?? [])
                        
                        DivideRectangle(height: 12, color: Color.neutral50)
                        DetailReviewView(viewModel: viewModel)
                            .tap {
                                // 리뷰 작성하러 가기 버튼
                                viewModel.send(action: .fetchReviewData)
                                guard let reviewEntity = viewModel.reviewEntity else { return }
                                router.navigateTo(.creatReview(reviewEntity))
                            }
                        Text("리뷰 수 \(viewModel.dataInfo?.reviewCnt ?? 100)")
                        DivideRectangle(height: 12, color: Color.neutral50)
                            .opacity(viewModel.dataInfo?.reviewThumbnailList == nil ? 0 : 1)
                        SimiliarProductView(viewModel: viewModel)
                            .opacity(viewModel.dataInfo?.reviewThumbnailList == nil ? 0 : 1)
                    }
                }
            }
            .padding(.bottom, 52)
        }
        .onAppear {
            viewModel.productId = productId
            viewModel.send(action: .fetchData)
//            viewModel.send(action: .tapNutrients)
        }
        .ZSNavigationBackButtonTitle(viewModel.dataInfo?.productName ?? "") {
            router.navigateBack()
        }.scrollIndicators(.hidden)
    }
}

#Preview {
    DetailMainView(productId: 207)
        .environmentObject(ToastAction())
}
