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
                        print("전체")
                        
                        router.navigateTo(
                            .categoryFilter(
                                "카페음료",
                                viewModel.cafeEntireCode,
                                "전체"
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
                                            print("datadatatatatat")
                                            viewModel.tapData = data.id
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
    }
}


#Preview {
    HomeMainView(viewModel: HomeMainViewModel(homeUsecase: HomeUsecase(homeRepoProtocol: HomeRepository(apiService: ApiService())), filterUsecase: FilterUsecase(filterRepoProtocol: FilterRepository(apiService: ApiService()))))
        .environmentObject(Router())
}
