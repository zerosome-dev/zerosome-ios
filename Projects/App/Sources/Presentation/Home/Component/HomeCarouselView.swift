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
    @EnvironmentObject var router: Router
    private let sampleList = ["출시예정", "온라인", "오프라인"]
    private let tagList = ["생수/음료","탄산음료"]
    
    var body: some View {
        VStack {
            CarouselNextView(width: $vm.width,
                             data: ZeroDrinkSampleData.data,
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
                                    KFImage(URL(string: data.photo))
                                        .resizable()
                                        .scaledToFit()
                                }
                            
                            Spacer()
                            VStack(spacing: 6) {
                                tagView()
                                ZSText(data.name, fontType: .subtitle1, color: .black)
                                    .padding(.bottom, 9)
                                storeView()
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
                    .onTapGesture {
                        router.navigateTo(.detailMainView)
                    }
            } lastContent: {
                launchImage()
                    .onTapGesture {
                        router.navigateTo(.homeSecondDepth("출시 예정 신상품", "신상품!!"))
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
    
    @ViewBuilder func tagView() -> some View {
        HStack(spacing: 8) {
            ForEach(tagList, id: \.self) { tag in
                ZSText(tag, fontType: .label1, color: Color.neutral500)
            }
        }
    }
    
    @ViewBuilder func storeView() -> some View {
        HStack(spacing: 6) {
            ForEach(sampleList, id: \.self) { tag in
                ZSText(tag, fontType: .label2, color: Color.neutral700)
                    .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
}

#Preview {
    HomeCarouselView()
}
