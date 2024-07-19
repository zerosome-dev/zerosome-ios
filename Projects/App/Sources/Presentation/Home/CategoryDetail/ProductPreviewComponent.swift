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
    var action: (() -> Void)?
    
    init (
        action: (() -> Void)? = nil
    ) {
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(Color.neutral50)
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                ZSText("브랜드브랜드", fontType: .body3, color: Color.neutral500)
                    .lineLimit(1)
                
                ZSText("상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명", fontType: .subtitle2, color: Color.neutral900)
                    .lineLimit(2)
                
                HStack(spacing: 2) {
                    ZerosomeAsset.ic_star_fill
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("0")
                    Text("(0)")
                }
                .applyFont(font: .body3)
                .foregroundStyle(Color.neutral400)
            }
        }
        .onTapGesture {
            action?()
        }
    }
}

extension ProductPreviewComponent {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

#Preview {
    ProductPreviewComponent()
}
