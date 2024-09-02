//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct HomeMainView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var toast: ToastAction
    @ObservedObject var viewModel: HomeMainViewModel
    
    init(viewModel: HomeMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HomeCategoryTitleView(
                    tapData: $viewModel.tapData,
                    productType: .tobeReleased(viewModel.tobeReleased),
                    title: "출시 예정 신상품",
                    subTitle: "출시 예정 및 최신 상품을 확인해 보세요",
                    type: .noneData
                )
                .tap {
                    router.navigateTo(
                        .tobeReleasedProduct(
                            viewModel.tobeReleased,
                            "출시 예정 신상품",
                            "새롭게 발매된 상품과 발매 예정 상품을 확인해보세요"
                        )
                    )
                }
                .environmentObject(toast)
                .padding(.top, 20)
                
                HomeCarouselView(data: viewModel.tobeReleased, viewModel: viewModel)
                    .frame(height: 327)
                
                HomeCategoryTitleView(
                    tapData: $viewModel.tapData,
                    productType: .homeCafe(viewModel.homeCafe),
                    title: "카페 음료",
                    subTitle: "카페에서 즐기는 제로",
                    type: .moreButton
                )
                .tap {
                    // 제목 tab -> 카페음료 전체 카테고리로 이동
//
//                    let temp = viewModel.homeCafe.filter { $0.d2CategoryId == "전체" }
//                        .map { $0.d2CategoryId }.joined()
//                    print("temp \(temp)")
//                    guard let totalCode = viewModel.homeCafe.first?.d1CategoryId else { return }
//                    router.navigateTo(.categoryFilter("카페 음료", totalCode, "전체"))
                }
                .tapSub {
                    print("viewmodel.tapdata \(viewModel.tapData)")
                    router.navigateTo(.detailMainView(viewModel.tapData))
                }
                .environmentObject(toast)
            }
        }
        .scrollIndicators(.hidden)
        .ZSmainNaviTitle("ZEROSOME")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.send(action: .cafe)
            viewModel.send(action: .tobeReleased)
        }
    }
}

#Preview {
    HomeMainView(viewModel: HomeMainViewModel(homeUsecase: HomeUsecase(homeRepoProtocol: HomeRepository(apiService: ApiService()))))
}
