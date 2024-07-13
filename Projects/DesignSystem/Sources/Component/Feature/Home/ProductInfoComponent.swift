//
//  ProductInfoComponent.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

// 출시 예정 신상품 Carousel 내부뷰를 위한 컴포넌트
public struct ProductInfoComponent: View {
    public enum ScrollData {
        case category
        case store
    }
    
    public let data: [String]
    public let type: ScrollData
    
    public init(data: [String], type: ScrollData) {
        self.data = data
        self.type = type
    }
    
    public var body: some View {
        switch type {
        case .category:
            HStack(spacing: 8) {
                ForEach(data, id: \.self) { index in
                    Text(index)
                        .foregroundStyle(Color.neutral500)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        case .store:
            HStack(spacing: 6) {
                ForEach(data, id: \.self) { index in
                    Text(index)
                        .padding(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .applyFont(font: .label1)
                        .foregroundStyle(Color.neutral700)
                        
                }
            }
        }
        
    }
}

#Preview {
    ProductInfoComponent(data: ["11", "22"], type: .category)
}
