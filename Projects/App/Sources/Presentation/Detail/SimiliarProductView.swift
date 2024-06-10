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
        VStack {
            Text("이 상품과 비슷한 상품이에요")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)

            // TODO: - component 넣기
            CommonButton(title: "작성완료", font: .subtitle2)
        }
    }
}

#Preview {
    SimiliarProductView()
}
