//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import FirebaseAnalytics

struct HomeMainView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: HomeMainViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    TitleComponent(
                        title: MainData.released.title,
                        subTitle: MainData.released.subtitle
                    )
                    .tap {
                        router.navigateTo(
                            .tobeReleasedProduct(
                                viewModel.tobeReleased,
                                MainData.released.title,
                                MainData.released.subtitle
                            )
                        )
                    }
                    .padding(.horizontal, 22)
                    
                    HomeCarouselView(
                        data: viewModel.tobeReleased,
                        viewModel: viewModel
                    )
                    .frame(height: 327)
                }
                
                VStack(spacing: 5) {
                    TitleComponent(
                        title: MainData.cafe.title,
                        subTitle: MainData.cafe.subtitle
                    )
                    .tap {
                        LogAnalytics.logD1Category(category: "Cafe")
                        router.navigateTo(
                            .categoryFilter(
                                "카페음료",
                                viewModel.cafeEntireCode,
                                viewModel.homeCafe.first?.d1CategoryId ?? ""
                            )
                        )
                    }
                    
                    HomeCategoryComponent(viewModel: viewModel)
                        .padding(.bottom, 15)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            if viewModel.filteredCafe.isEmpty {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.neutral50)
                                    .frame(width: UIScreen.main.bounds.width - 44, height: 150)
                                    .overlay {
                                        ZSText("해당 카테고리 제품은 준비 중이에요 💦", fontType: .subtitle1)
                                    }
                            } else {
                                ForEach(viewModel.filteredCafe.prefix(10), id: \.id) { data in
                                    ProductPreviewComponent(data: data)
                                        .tap {
                                            router.navigateTo(.detailMainView(data.id, data.brand))
                                                
                                            LogAnalytics.logD2Category(category: "\(data.brand)")
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 22)
            }
        }
        .scrollIndicators(.hidden)
        .ZSmainNaviTitle("ZEROSOME")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.send(action: .cafe)
            viewModel.send(action: .tobeReleased)
        }
        .onDisappear {
            viewModel.tappedCafeCategory = ""
        }
    }
}


#Preview {
    HomeMainView(viewModel: HomeMainViewModel(homeUsecase: HomeUsecase(homeRepoProtocol: HomeRepository(apiService: ApiService())), filterUsecase: FilterUsecase(filterRepoProtocol: FilterRepository(apiService: ApiService()))))
        .environmentObject(Router())
}
