//
//  NoneFilterResultView.swift
//  App
//
//  Created by 박서연 on 2024/07/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct NoneFilterResultView: View {
    var body: some View {
        VStack(spacing: 10) {
            ZSText("해당하는 상품이 없어요\n검색 조건을 변경해 보세요.", fontType: .subtitle1, color: Color.primaryFF6972)
                .multilineTextAlignment(.center)
            
            ZerosomeAsset.ic_filter_empty
                .resizable()
                .frame(width: 64, height: 64)
        }
    }
}

#Preview {
    NoneFilterResultView()
}
