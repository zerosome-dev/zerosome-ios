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
    
    func returnDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy.MM.dd"
        let formattedDateString = displayFormatter.string(from: date)
        return formattedDateString
    }
}

struct ReviewCarouselView: View {
    
    @StateObject private var vm = CarouselViewModel()
    @ObservedObject private var viewModel: DetailMainViewModel
    @EnvironmentObject var router: Router
    let data: [ReviewThumbnailResult]
    
    init(
        data: [ReviewThumbnailResult],
        viewModel: DetailMainViewModel
    ) {
        self.data = data
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            CarouselNextView(
                width: $vm.width,
                data: (data.count < 5) ? data : Array(data.prefix(5)),
                edgeSpacing: 21.5,
                contentSpacing: 10,
                totalSpacing: 22,
                contentHeight: 102
            ) { data in
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.neutral100)
                    .overlay {
                        VStack(spacing: 16) {
                            HStack {
                                HStack(spacing: 4) {
                                    StarComponent(
                                        rating: data.rating,
                                        size: 16
                                    )
                                    ZSText("\(data.rating)", fontType: .body3, color: Color.neutral700)
                                }
                                Spacer()
                                ZSText(data.regDate, fontType: .body4, color: Color.neutral400)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            ZSText(data.reviewContents, fontType: .body2, color: Color.neutral700)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(2)
                        }
                        .background(Color.white)
                        .padding(14)
                    }
            } lastContent: { EmptyView() }
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

struct HomeCarouselView: View {
    
    @StateObject private var vm = CarouselViewModel()
    @ObservedObject private var viewModel: HomeMainViewModel
    @EnvironmentObject var router: Router
    let data: [HomeRolloutResult]
    
    init(
        data: [HomeRolloutResult],
        viewModel: HomeMainViewModel
    ) {
        self.data = data
        self.viewModel = viewModel
    }
    
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
                                    KFImage(URL(string: data.image))
                                        .placeholder {
                                            ProgressView()
                                                .tint(Color.primaryFF6972)
                                        }
                                        .resizable()
                                        .scaledToFill()
                                }
                            
                            Spacer()
                            VStack(spacing: 6) {
                                HStack(spacing: 8) {
                                    ZSText("#\(data.d1Category)", fontType: .label1, color: Color.neutral500)
                                    ZSText("#\(data.d2Category)", fontType: .label1, color: Color.neutral500)
                                }
                                
                                ZSText(data.name, fontType: .subtitle1, color: .black)
                                    .padding(.bottom, 9)
                                
                                HStack(spacing: 6) {
                                    ForEach(data.salesStore, id: \.self) { store in
                                        ZSText(store, fontType: .label2, color: Color.neutral700)
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
                        router.navigateTo(.detailMainView(data.id))
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
