//
//  CategoryDetailView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CategoryDetailView: View {
    public let rows = Array(repeating: GridItem(.flexible()), count: 1)
    public let data: [String]
    
    public init(data: [String]) {
        self.data = data
    }
    
    public var body: some View {
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
    }
}

#Preview {
    CategoryDetailView(data: ["태그1", "태그2", "태그3", "태그4", "태그5", "태그6"])
}
