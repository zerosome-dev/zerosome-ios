//
//  ProductInfoView.swift
//  App
//
//  Created by 박서연 on 2024/07/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ProductInfoView: View {
    let rating: Int
    let reviewCnt: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZSText("브랜드명브랜드명브랜드명", fontType: .body2, color: Color.neutral500)
            ZSText("품명상품명상품명상품명상품명상품명상품명상품명상품명상품명", fontType: .subtitle1, color: Color.neutral900)
                .lineLimit(1)
            
            DivideRectangle(height: 1, color: Color.neutral100)
            
            HStack(spacing: 6) {
                StarComponent(rating: rating)
                
                ZSText("(rating)", fontType: .subtitle1, color: Color.neutral900)
                
                Rectangle()
                    .frame(width: 10,height: 1)
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(Color.neutral300)
                
                ZSText("(reviewCnt)개의 리뷰", fontType: .body2, color: Color.neutral500)
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    ProductInfoView(rating: 1, reviewCnt: 1)
}
