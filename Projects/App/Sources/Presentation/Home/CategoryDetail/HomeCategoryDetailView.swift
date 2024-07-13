//
//  HomeCategoryDetailView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

// 홈 화면 -> 더보기 탭시 이동 뷰
struct HomeCategoryDetailView: View {
    let title: String
    let subTitle: String
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 11, alignment: .center), count: 2)

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HomeCategoryTitleView(title: title,
                                      subTitle: subTitle,
                                      type: .none,
                                      paddingType: false).padding(.top, 12)
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<10, id: \.self) { index in
                        ProductPreviewComponent()
                    }
                }
            }
            .padding(.horizontal, 22)
        }
        .ZSNavigationBackButtonTitle("생수 / 음료") {
            print("dd")
        }
    }
}

#Preview {
    NavigationStack {
        HomeCategoryDetailView(title: "출시 예정 신상품", subTitle: "새롭게 발매된 어쩌구")
    }
}
