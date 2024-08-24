//
//  HomeCategoryDetailView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct TobeReleasedProductView: View {
    
    @EnvironmentObject var router: Router
    let title: String
    let subTitle: String
    let data: [HomeRolloutResult]
    let columns: [GridItem] = Array(
        repeating: .init(.flexible(),
                         spacing: 11,
                         alignment: .center), count: 2
    )
    
    let platform: [String] = ["출시예정", "온라인", "오프라인"]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 2) {
                    ZSText(title, fontType: .heading1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZSText(subTitle, fontType: .body2, color: Color.neutral500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.id) { data in
                        VStack(alignment: .leading, spacing: 8) {
                            Rectangle()
                                .fill(Color.neutral50)
                                .frame(maxWidth: .infinity)
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 4) {
                                ZSText(data.d2Category ?? "", fontType: .body3, color: Color.neutral500)
                                    .lineLimit(1)
                                
                                ZSText(data.name ?? "", fontType: .subtitle2, color: Color.neutral900)
                                    .lineLimit(2)
                                
                                HStack {
                                    ForEach(platform, id: \.self) { platform in
                                        ZSText(platform, fontType: .label2, color: Color.neutral700)
                                            .padding(.init(top: 3,leading: 6,bottom: 3,trailing: 6))
                                            .background(Color.neutral50)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 22)
        }
        .scrollIndicators(.hidden)
        .ZSnavigationBackButton {
            router.navigateBack()
        }
    }
}

#Preview {
    TobeReleasedProductView(title: "출시 예정 신상품", subTitle: "새롭게 발매된 어쩌구", data: [])
}
