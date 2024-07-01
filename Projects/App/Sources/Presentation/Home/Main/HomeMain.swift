//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct HomeMain: View {
    var body: some View {
        ScrollView {
            Spacer().frame(height: 46)
            PagingBannerView(pageCount: 5) {
                ForEach(0..<5) { index in
                    Rectangle()
                        .fill(Color.neutral200)
                        .overlay {
                            Text("\(index+1)")
                        }
                }
            }
            .frame(height: 240)
            .padding(.bottom, 30)

            VStack(spacing: 0) {
                HomeSubTitleView(title: "지금 핫한 카페 음료", subTitle: "설명 문구를 입력해주세요.", type: .none)
                .padding(.bottom, 16)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { _ in
                            ReleasedCarouselView()
                                .frame(maxWidth: 400)
                        }
                    }
                }

                HomeSubTitleView(title: "[생수/음료] 인기 음료 순위", subTitle: "설명 문구를 입력해주세요.", type: .rightButton)
                    .padding(.init(top: 40, leading: 0, bottom: 16, trailing: 0))
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { i in
                            ProductPreviewComponent(rank: i+1, rankLabel: false)
                                .frame(maxWidth: 150)
                        }
                    }
                }
                
                HomeSubTitleView(title: "[카페음료] 인기 음료 순위", subTitle: "설명 문구를 입력해주세요.", type: .ranking)
                    .padding(.init(top: 40, leading: 0, bottom: 16, trailing: 0))
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { i in
                            ProductPreviewComponent(rank: i+1, rankLabel: true)
                                .frame(maxWidth: 150)
                        }
                    }
                }
            }
            .padding(.horizontal, 22)
        }
    }
}

#Preview {
    HomeMain()
}
