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
//                    guard let totalCode = viewModel.homeCafe.first?.d1CategoryId else { return }
//                    router.navigateTo(.categoryFilter("카페 음료", totalCode, "전체"))
                }
                .tapSub {
                    router.navigateTo(.detailMainView(viewModel.tapData))
                }
            }
        }
        .scrollIndicators(.hidden)
        .ZSmainNaviTitle("ZEROSOME")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
//            viewModel.send(action: .cafe)
//            viewModel.send(action: .tobeReleased)
        }
    }
}

#Preview {
    HomeMainView(viewModel: HomeMainViewModel(homeUsecase: HomeUsecase(homeRepoProtocol: HomeRepository(apiService: ApiService()))))
}
