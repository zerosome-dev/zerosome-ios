//
//  HomeCarouselView.swift
//  App
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

class CarouselViewModel: ObservableObject {
    @Published var width: CGFloat = 0
}

struct HomeCarouselView: View {
    
    @StateObject private var vm = CarouselViewModel()
    @ObservedObject private var viewModel: HomeMainViewModel
    @EnvironmentObject var router: Router
    let data: [HomeRolloutResponseDTO]
    
    init(
        data: [HomeRolloutResponseDTO],
        viewModel: HomeMainViewModel
    ) {
        self.data = data
        self.viewModel = viewModel
    }
    
    private let sampleList = ["출시예정", "온라인", "오프라인"]
    private let tagList = ["생수/음료","탄산음료"]
    
    var body: some View {
        VStack {
            CarouselNextView(width: $vm.width,
                             data: Array(data.prefix(10)),
                             edgeSpacing: 24,
                             contentSpacing: 14,
                             totalSpacing: 22,
                             contentHeight: 327)
            { data in
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .overlay {
                        VStack {
                            Rectangle()
                                .fill(Color.neutral50)
                                .frame(height: 216)
                                .overlay {
                                    KFImage(URL(string: data.image ?? ""))
                                        .placeholder {
                                            ProgressView()
                                                .tint(Color.primaryFF6972)
                                        }
                                        .resizable()
                                        .scaledToFit()
                                }
                            
                            Spacer()
                            VStack(spacing: 6) {
                                HStack(spacing: 8) {
                                    ZSText(data.d1Category ?? "", fontType: .label1, color: Color.neutral500)
                                    ZSText(data.d2Category ?? "", fontType: .label1, color: Color.neutral500)
                                }
                                
                                ZSText(data.name ?? "", fontType: .subtitle1, color: .black)
                                    .padding(.bottom, 9)
                                
                                HStack(spacing: 6) {
                                    ForEach(data.salesStore ?? [], id: \.self) { store in
                                        ZSText(store ?? "", fontType: .label2, color: Color.neutral700)
                                            .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                                            .background(Color.neutral50)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
                    .onTapGesture {
                        router.navigateTo(.detailMainView(data.id ?? 0))
                    }
            } lastContent: {
                launchImage()
                    .onTapGesture {
                        router.navigateTo(.tobeReleasedProduct(
                            viewModel.tobeReleased,
                            "출시 예정 신상품",
                            "새롭게 발매된 상품과 발매 예정 상품을 확인해보세요")
                        )
                    }
            }
        }
        .padding(.horizontal, 22)
    }
    
    @ViewBuilder func launchImage() -> some View {
        ZerosomeAsset.card_launch_more
            .resizable()
            .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
    }
    
    @ViewBuilder func storeView(data: HomeRolloutResponseDTO) -> some View {
        HStack(spacing: 6) {
            ForEach(data.salesStore ?? [], id: \.self) { store in
                ZSText(store ?? "", fontType: .label2, color: Color.neutral700)
                    .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
}

//#Preview {
//    HomeCarouselView(data: .init(), viewModel = HomeMainViewModel())
//}
