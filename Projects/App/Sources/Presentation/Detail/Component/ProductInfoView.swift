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
    let name: String
    let brand: String
    let rating: Double
    let reviewCnt: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZSText(brand, fontType: .body2, color: Color.neutral500)
            ZSText(name, fontType: .subtitle1, color: Color.neutral900)
                .lineLimit(1)
            
            DivideRectangle(height: 1, color: Color.neutral100)
            
            HStack(spacing: 6) {
                StarComponent(rating: rating, size: 16)
                
                ZSText("\(rating)", fontType: .subtitle1, color: Color.neutral900)
                
                Rectangle()
                    .frame(width: 10,height: 1)
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(Color.neutral300)
                
                ZSText("\(reviewCnt)개 리뷰", fontType: .body2, color: Color.neutral500)
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    ProductInfoView(name: "name", brand: "brand", rating: 1, reviewCnt: 1)
}
