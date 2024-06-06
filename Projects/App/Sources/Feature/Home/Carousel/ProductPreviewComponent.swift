//
//  NowHotView.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ProductPreviewComponent: View {
    var rank: Int
    var rankLabel: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(Color.neutral50)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .bottomLeading) {
                    if rankLabel {
                        Text("\(rank)")
                            .font(.custom(DesignSystemFontFamily.Pretendard.bold.name, size: 32))
                            .padding(.init(top: 0, leading: 12, bottom: 2, trailing: 0))
                    }
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("[브랜드명브랜드명브랜...]")
                    .lineLimit(1)
                    .foregroundStyle(Color.neutral500)
                
                Text("상품명입니다 상품명입니다 상품명입니다  상품명입니다 상품명")
                    .lineLimit(2)
                    .foregroundStyle(Color.black)
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)
                    Text("0 (0)")
                        .foregroundStyle(Color.neutral400)
                }
            }
        }
    }
}

#Preview {
    ProductPreviewComponent(rank: 1, rankLabel: false)
}
