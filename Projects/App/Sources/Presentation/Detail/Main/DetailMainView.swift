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

    let navigationTitle: String
    let productId: Int
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel: DetailMainViewModel
    
//    init(
//        productId: Int,
//        navigationTitle: String,
//        viewModel: DetailMainViewModel
//    ) {
//        self.productId = productId
//        self.navigationTitle = navigationTitle
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "리뷰 작성", font: .subtitle2)
                .tap {
                    if authViewModel.authenticationState == .guest {
                        viewModel.guestToggle = true
                    } else {
                        guard let reviewEntity = viewModel.reviewEntity else { return }
                        router.navigateTo(.creatReview(reviewEntity))
                    }
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
                        onOfflineView()
                        DetailReviewView(viewModel: viewModel)
                            .tap {
                                guard let reviewEntity = viewModel.reviewEntity else { return }
                                router.navigateTo(.creatReview(reviewEntity))
                            }
                            .tapTitle {
                                guard let productId = viewModel.dataInfo?.productId,
                                let reviewEntity = viewModel.reviewEntity else { return }
                                router.navigateTo(.reviewList("\(productId)", reviewEntity))
                            }
                            .frame(height: 246)
                        
                        DivideRectangle(height: 12, color: Color.neutral50)
                            .opacity(viewModel.dataInfo?.reviewThumbnailList == nil ? 0 : 1)
                        similarProduct()
                    }
                }
            }
            .padding(.bottom, 52)
        }
        .onAppear {
            viewModel.productId = productId
            viewModel.send(action: .fetchData)
            viewModel.navigationTitle = self.navigationTitle
        }
        .ZSNavigationBackButtonTitle(self.navigationTitle) {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
        .ZAlert(
            isShowing: $viewModel.guestToggle,
            type: .contentSButton(
                title: "더 많은 콘텐츠가 기다리고 있어요",
                LButton: "회원가입/로그인",
                content: "로그인 후 모든 기능으르 이용해 보세요!"
            ), leftAction:  {
                viewModel.guestToggle = false
                router.popToRoot()
                authViewModel.authenticationState = .initial
            })
    }
    
    @ViewBuilder
    func onOfflineView() -> some View {
        if let optionalBinding = viewModel.dataInfo {
            let online = optionalBinding.onlineStoreList
            let offlineStoreList = optionalBinding.offlineStoreList
            
            if !online.isEmpty, offlineStoreList.isEmpty {
                OnlineStoreView(onlineStore: online)
                DivideRectangle(height: 12, color: Color.neutral50)
            } else if !online.isEmpty, !offlineStoreList.isEmpty {
                OnlineStoreView(onlineStore: online)
                OfflineStoreView(offlineStore: offlineStoreList)
                DivideRectangle(height: 12, color: Color.neutral50)
            } else if online.isEmpty, !offlineStoreList.isEmpty {
                OfflineStoreView(offlineStore: offlineStoreList)
                DivideRectangle(height: 12, color: Color.neutral50)
            } else {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    func similarProduct() -> some View {
        if let similar = viewModel.dataInfo?.similarProductList, !similar.isEmpty {
            SimiliarProductView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

//#Preview {
//    DetailMainView(navigationTitle: "음료", productId: 217, viewModel: DetailMainViewModel(detailUseCase: DetailUsecase(detailRepoProtocol: DetailRepository(apiService: ApiService()))))
//        .environmentObject(ToastAction())
//}
