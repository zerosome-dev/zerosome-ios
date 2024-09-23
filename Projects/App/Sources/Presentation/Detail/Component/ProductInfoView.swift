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
    @ObservedObject var viewModel: DetailMainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZSText(viewModel.dataInfo?.brandName ?? "", fontType: .body2, color: Color.neutral500)
            ZSText(viewModel.dataInfo?.productName ?? "", fontType: .subtitle1, color: Color.neutral900)
                .lineLimit(1)
            
            DivideRectangle(height: 1, color: Color.neutral100)
            
            HStack(spacing: 6) {
                StarComponent(rating: viewModel.dataInfo?.rating ?? 0.0, size: 16)
                ZSText(String(format: "%.1f", viewModel.dataInfo?.rating ?? 0.0), fontType: .subtitle1, color: Color.neutral900)
                
                Rectangle()
                    .frame(width: 10,height: 1)
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(Color.neutral300)
                
                ZSText("\(viewModel.dataInfo?.reviewCnt ?? 0)개 리뷰", fontType: .body2, color: Color.neutral500)
            }
        }
        .padding(.horizontal, 22)
    }
}
