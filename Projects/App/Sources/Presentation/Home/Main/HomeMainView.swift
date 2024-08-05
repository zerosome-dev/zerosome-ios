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
    @StateObject private var viewModel = HomeMainViewModel(
        homeUsecase: HomeUsecase(
            homeRepoProtocol: HomeRepository(
                apiService: ApiService()
            )
        )
    )
    
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
                .tap { router.navigateTo(.tobeReleasedProduct("출시 예정 신상품", "신상품!!")) }
                .padding(.top, 20)
                
                HomeCarouselView()
                    .frame(height: 327)
                
                HomeCategoryTitleView(
                    tapData: $viewModel.tapData,
                    productType: .homeCafe(viewModel.homeCafe),
                    title: "생수/음료",
                    subTitle: "제로로 걱정 없이 즐기는 상쾌한 한 모금",
                    type: .moreButton
                )
                .tap { router.navigateTo(.categoryFilter("생수/음료", nil))}
                .tapSub { router.navigateTo(.detailMainView(viewModel.tapData)) }
                
                
                DivideRectangle(height: 12, color: Color.neutral50)
                
                HomeCategoryTitleView(
                    tapData: $viewModel.tapData,
                    productType: .homeCafe(viewModel.homeCafe),
                    title: "카페음료",
                    subTitle: "카페에서 즐기는 제로",
                    type: .moreButton
                )
                .tap { router.navigateTo(.categoryFilter("카페음료", nil)) }
                .tapSub { router.navigateTo(.detailMainView(viewModel.tapData)) }
            }
        }
        .scrollIndicators(.hidden)
        .ZSmainNaviTitle("ZEROSOME")
        .onAppear {
            viewModel.send(action: .cafe)
//            viewModel.send(action: .tobeReleased)
        }
    }
}

#Preview {
    HomeMainView()
}
