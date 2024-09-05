//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum MainData {
    case released
    case cafe
    
    var title: String {
        switch self {
        case .released:
            return "출시 예정 신상품"
        case .cafe:
            return "지금 핫한 카페 음료"
        }
    }
    
    var subtitle: String {
        switch self {
        case .released:
            return "출시 예정 및 최신 상품을 확인해 보세요"
        case .cafe:
            return "트렌디한 카페 음료를 지금 바로 확인해보세요"
        }
    }
}

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
                        //                        router.navigateTo(
                        //                        .tobeReleasedProduct(
                        //                            viewModel.tobeReleased,
                        //                            "출시 예정 신상품",
                        //                            "새롭게 발매된 상품과 발매 예정 상품을 확인해보세요"
                        //                        )
                        //                    )
                    }
                    .padding(.horizontal, 22)
                    HomeCarouselView(data: viewModel.tobeReleased, viewModel: viewModel)
                        .frame(height: 327)
                }
                
                VStack(spacing: 5) {
                    TitleComponent(
                        title: MainData.cafe.title,
                        subTitle: MainData.cafe.subtitle
                    )
                    .tap {
                        print("전체")
                        //                            let temp = viewModel.homeCafe.filter { $0.d2CategoryId == "전체" }
                        //                            .map { $0.d2CategoryId }.joined()
                        //                        print("temp \(temp)")
                        //                        guard let totalCode = viewModel.homeCafe.first?.d1CategoryId else { return }
                        //                        router.navigateTo(.categoryFilter("카페 음료", totalCode, "전체"))
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
