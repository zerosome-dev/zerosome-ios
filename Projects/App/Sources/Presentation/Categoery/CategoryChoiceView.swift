//
//  CategoryChoiceView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

enum CategoryDetail: String, CaseIterable {
    case category = "전체" // Defalut를 전체로 설정
    case brand = "브랜드"
    case update = "최신 등록순"
    case zeroTag = "제로태그"
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .category:
            CategoryBottomSheet()
        case .brand:
            EmptyView()
        case .update:
            EmptyView()
        case .zeroTag:
            EmptyView()
        }
    }
}

struct CategoryChoiceView: View {
    let rows = Array(repeating: GridItem(.flexible()), count: 1)
    let data: [String]
    
    init(data: [String]) {
        self.data = data
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 6) {
                ForEach(data, id: \.self) { type in
                    HStack(spacing: 2) {
                        Text(type)
                            .applyFont(font: .label1)
                        ZerosomeAsset.ic_arrow_bottom
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryChoiceView(data: ZeroDrinkSampleData.drinkType)
}
