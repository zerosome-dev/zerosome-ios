//
//  ReleasedCarouselView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct ReleasedCarouselView: View {
    public let category = ["#생수/음료", "#탄산음료"]
    public let store = ["쿠팡", "이마트", "판매처"]
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 14) {
            Rectangle()
                .fill(Color.neutral200)
                .frame(height: 216)
                .frame(maxWidth: .infinity)
            
            VStack {
                ProductInfoComponent(data: category, type: .category)
                    .padding(.bottom, 6)
                
                Text("상품명상품명상품명")
                    .applyFont(font: .subtitle1)
                    .lineLimit(1)
                    .padding(.bottom, 15)
                
                ProductInfoComponent(data: store, type: .store)
                    .padding(.bottom, 16)
            }
            .frame(alignment: .center)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ReleasedCarouselView()
}
