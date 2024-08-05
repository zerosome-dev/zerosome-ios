//
//  SimiliarProductView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct SimiliarProductView: View {
    var body: some View {
        VStack(spacing: 16) {
            CommonTitle(title: "이 상품과 비슷한 상품이에요", type: .solo)
                .frame(maxWidth: .infinity, alignment: .leading)
            
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(0..<10) { i in
//                        ProductPreviewComponent()
//                            .frame(maxWidth: 150)
//                    }
//                }
//            }
//            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    SimiliarProductView()
}
